#!/bin/bash
# Helper script for OwnCloud salt automation.


# Constants.
EXIT_INVALID_COMMAND=1
EXIT_NOT_INSTALLED=2
EXIT_OK=3
EXIT_WRONG_USER=4

HTTP_USER="www-data"
OWNCLOUD_ROOT="/var/www/owncloud"
OWNCLOUD_CTL="./occ"


# Functions.
show_help() {
  echo -en "/opt/spogliani/owncloud/owncloudclt.sh COMMAND [OPTIONS]
Helper script for OwnCloud salt automation.

COMMAND:
  check install
    Checks the state of the system.
    The required argument to check is the aspect of the system to check.
      * install: checks that the system is installed.

  help
    Show this message.
"
}


# Commans.
check() {
  what=$1
  case "${what}" in
    install) check_install;;
    *)
      echo "Unkonw check argument: '${what}'."
      show_help
      exit ${EXIT_INVALID_COMMAND}
      ;;
  esac
}

check_install() {
  cd ${OWNCLOUD_ROOT}
  installed=${OWNCLOUD_CTL} list | grep -c 'ownCloud is not installed'
  if [ "${installed}" -eq 1 ]; then
    exit ${EXIT_NOT_INSTALLED}
  else
    exit ${EXIT_OK}
  fi
}


### MAIN ###
# Check pre-conditions.
if [ "$(whoami)" != "${HTTP_USER}" ]; then
  echo "This script must run as the ${HTTP_USER} user."
  exit ${EXIT_WRONG_USER}
fi


# Process command.
cmd=$1
shift

case "${cmd}" in
  check) check $*;;
  help)  show_help;;
  *)
    echo "Unsupported command: '${cmd}'."
    show_help
    exit ${EXIT_INVALID_COMMAND}
    ;;
esac
