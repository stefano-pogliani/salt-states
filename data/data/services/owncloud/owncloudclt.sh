#!/bin/bash
# Helper script for OwnCloud salt automation.


# Constants.
EXIT_INVALID_COMMAND=1
EXIT_WRONG_USER=2


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


### MAIN ###
# Check pre-conditions.
if [ "$(whoami)" != "www-data" ]; then
  echo "This script must run as the www-data user."
  exit ${EXIT_WRONG_USER}
fi


# Process command.
cmd=$1
shift

case "${cmd}" in
  help) show_help;;
  *)
    echo "Unsupported command: '${cmd}'."
    show_help
    exit ${EXIT_INVALID_COMMAND}
esac
