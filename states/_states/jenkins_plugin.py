# -*- coding: utf-8 -*-
'''
State module to install Jenkins Plugins.
'''

# Import python libs
from __future__ import absolute_import
import logging

log = logging.getLogger(__name__)


def ensure(*args, **kwargs):
  log.debug(("~~~", args, kwargs))

