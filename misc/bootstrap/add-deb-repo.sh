#!/bin/bash
#
# Script to install SaltStack debian repository.

BRANCH="wheezy-saltstack"
SOURCES="/etc/apt/sources.list"

echo deb http://debian.saltstack.com/debian "${BRANCH}" main >> ${SOURCES}
wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -

apt-get update

