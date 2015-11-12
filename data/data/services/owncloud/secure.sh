#!/bin/bash
# OwnCloud hardening helper.


# Varaibles.
OC_DATA_PATH="/data/owncloud"
OC_PATH="/var/www/owncloud"
WEB_GROUP="www-data"
WEB_USER="www-data"

# Set file permissions.
find ${OC_PATH}/ -type f -print0 | xargs -0 chmod 0640
find ${OC_PATH}/ -type d -print0 | xargs -0 chmod 0750

chown -R root:${WEB_GROUP} ${OC_PATH}/
chown -R ${WEB_USER}:${WEB_GROUP} ${OC_PATH}/apps/
chown -R ${WEB_USER}:${WEB_GROUP} ${OC_PATH}/config/
chown -R ${WEB_USER}:${WEB_GROUP} ${OC_PATH}/themes/
chown root:${WEB_GROUP} ${OC_PATH}/.htaccess

chmod 0644 ${OC_PATH}/.htaccess


find ${OC_DATA_PATH}/ -type f -print0 | xargs -0 chmod 0640
find ${OC_DATA_PATH}/ -type d -print0 | xargs -0 chmod 0750

chown -R ${WEB_USER}:${WEB_GROUP} ${OC_DATA_PATH}/
chown root:${WEB_GROUP} ${OC_DATA_PATH}/.htaccess

chmod 0644 ${OC_DATA_PATH}/.htaccess
