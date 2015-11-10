include:
  - services.owncloud
  - services.owncloud.install


# Deploy required files.
owncloud-apache-crt:
  file.managed:
    - name:   /data/www/certs/cloud.crt
    - source: salt://priv-data/services/owncloud/nephele-cloud.crt
    - makeDirs: True

    - group: www-data
    - user:  www-data
    - mode:  440

owncloud-apache-key:
  file.managed:
    - name:   /data/www/certs/cloud.key
    - source: salt://priv-data/services/owncloud/nephele-cloud.key
    - makeDirs: True

    - group: www-data
    - user:  www-data
    - mode:  440

owncloud-apache-vhost:
  file.managed:
    - name:   /etc/apache2/sites-available/owncloud
    - source: salt://data/services/owncloud/apache-vhost

    - group: root
    - user:  root
    - mode:  644

    - require:
      - cmd: owncloud-occ-install
      - file: owncloud-apache-crt
      - file: owncloud-apache-key


# Enable apache configurations.
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
