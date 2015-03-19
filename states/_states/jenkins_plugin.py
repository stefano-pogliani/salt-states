# -*- coding: utf-8 -*-
"""
State module to install Jenkins Plugins.
"""

# Import python modules.
from __future__ import absolute_import
import json
import logging
import os


# Import external modules.
import requests


log = logging.getLogger(__name__)


class PluginCache(object):
  PLUGINS_URL="https://updates.jenkins-ci.org/update-center.json"

  def __init__(self):
    super(PluginCache, self).__init__()
    self._cache = None

  def _update(self, force=False):
    if force or self._cache is None:
      log.info("Downloading plugin information")
      # Fetch the JSONP file.
      data = requests.get(PluginCache.PLUGINS_URL).text
      data = data.split("\n")[1]
      self._cache = json.loads(data)["plugins"]

  def download(self, name, target):
    self._update()
    if name not in self._cache:
      raise Exception("Cannot download inexisting plugin")

    location = self._cache[name]["url"]
    log.debug("Downloading Jenkins Plugin {name} from {url}".format(
      name=name, url=location
    ))

    stream = requests.get(location, stream=True)
    with open(target, "wb") as f:
      for chunk in stream.iter_content(chunk_size=1024):
        if chunk: # filter out keep-alive new chunks
          f.write(chunk)
          f.flush()

  def get_latest_version(self, name):
    self._update()
    if name in self._cache:
      return self._cache[name]["version"]
    return None

_cache = PluginCache()


def ensure(home="/var/lib/jenkins", name=None, update=True, **kwargs):
  result = {
    "changes": {},
    "comment": "",
    "name":    name,
    "result":  True
  }

  # Check if plugin is available and fetch the version.
  latest_version = _cache.get_latest_version(name)
  log.debug("Found plugin {name}, version {version}".format(
    name=name, version=latest_version
  ))

  # Check if plugin is installed.
  download_target   = os.path.join(home, "plugins", name + ".hpi")
  metadata_location = os.path.join(
      home, "plugins", name, "META-INF", "MANIFEST.MF"
  )
  installed = os.exists(metadata_location)
  outdated  = False
  version   = None

  # If it is, figure out the installed version.
  if installed:
    with open(metadata_location, "r") as metadata:
      version = [
          line for line in metadata.readlines()
          if line.startswith("Plugin-Version: ")
      ][0][15:]
      outdated = version != latest_version
      log.debug("Detected installed version {version}".format(version=version))

  # Install update if needed and requested.
  if not installed or (update and outdated):
    _cache.download(name, download_target)
    result["changes"][name] = {
      "new": latest_version,
      "old": version
    }

  else:
    change = {}

  log.debug(("~~~", kwargs))
  return result

