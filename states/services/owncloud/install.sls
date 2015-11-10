{% set config = salt["pillar.get"]("owncloud:server", {}) %}


include:
  - services.owncloud


owncloud-occ-install:
  cmd.run:
    - name: >
        php occ maintenance:install
        --no-interaction
        --data-dir "/data/owncloud"
        --admin-user "{{ config.admin.user }}"
        --admin-pass "{{ config.admin.password }}"
        --database "mysql"
        --database-name "owncloud"
        --database-host "{{ config.db.host }}"
        --database-user "{{ config.db.user }}"
        --database-pass "{{ config.db.password }}"

    - unless: /opt/spogliani/owncloud/owncloudctl check install
    - cwd:    /var/www/owncloud
    - group:  www-data
    - user:   www-data

    - require:
      - mysql_database: owncloud-db-ensure
      - mysql_user:   owncloud-dbuser-ensure
      - mysql_grants: owncloud-dbuser-grant-all

      - pkg:  owncloud-install
      - file: owncloud-data-create
      - file: owncloud-clt-script


{% set config = salt["pillar.get"]("owncloud:server:config") %}
owncloud-config-deploy:
  file.managed:
    - name:   /var/www/owncloud/config/salt.config.php
    - source: salt://data/services/owncloud/salt.config.php

    - group: www-data
    - user:  www-data
    - mode:  640

    - template: jinja
    - context:
        domains: {{ config.domains }}

    - require:
      - cmd: owncloud-occ-install

owncloud-apache-vhost:
  file.managed:
    - name:   /etc/apache2/sites-available/owncloud
    - source: salt://data/services/owncloud/apache-vhost

    - group: www-data
    - user:  www-data
    - mode:  640

    - require:
      - cmd: owncloud-occ-install

owncloud-apache-site-enable:
  cmd.run:
    - name:    a2ensite owncloud
    - creates: /etc/apache2/sites-enabled/owncloud
    - require:
      - file: owncloud-apache-vhost
      - pkg:  owncloud-install

owncloud-apache-ssl-module:
  cmd.run:
    - name: a2enmod ssl
    - require:
      - pkg: owncloud-install


# Restart apache
owncloud-apache-restart:
  service.running:
    - name: apache2
    - require:
      - pkg: owncloud-install
      - cmd: owncloud-occ-install

    - watch:
      - cmd:  owncloud-apache-site-enable
      - cmd:  owncloud-apache-ssl-module
      - file: owncloud-apache-vhost
