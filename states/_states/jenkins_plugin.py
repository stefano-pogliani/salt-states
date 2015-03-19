# -*- coding: utf-8 -*-
"""
State module to install Jenkins Plugins.
"""

# Import python modules.
from __future__ import absolute_import
import logging

# Import salt modules.
from salt.utils import http


_plugin_cache = None
log = logging.getLogger(__name__)

_PLUGINS_URL="https://updates.jenkins-ci.org/update-center.json"


def _get_latest_version(name):
  if _plugin_cache is None:
    log.info("Downloading plugin information")
    _plugin_cache = http.query(_PLUGINS_URL)

  log.debug(("~~~", _plugin_cache)


def ensure(name=None, update=True, *args, **kwargs):
  result = {
    "changes": {},
    "comment": "",
    "name":    name,
    "result":  True
  }

  # Check if plugin is available and fetch the version.
  latest_version = _get_latest_version(name)
  log.debug("Found plugin {name}, version {version}".format(
    name=name, version-latest_version
  ))

  # Check if plugin is installed.
  # If it is, figure out the installed version.
  # Install update if needed and requested.

  log.debug(("~~~", args, kwargs))
  return result

