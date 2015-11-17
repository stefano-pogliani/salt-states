include:
  - services.owncloud


# Deploy required files.
owncloud-apache-crt:
  file.managed:
    - name:   /data/www/certs/cloud.crt
    - source: salt://priv-data/services/owncloud/nephele-cloud.crt
    - makedirs: True

    - group: www-data
    - user:  www-data
    - mode:  440

owncloud-apache-key:
  file.managed:
    - name:   /data/www/certs/cloud.key
    - source: salt://priv-data/services/owncloud/nephele-cloud.key
    - makedirs: True

    - group: www-data
    - user:  www-data
    - mode:  440

owncloud-apache-vhost:
  file.managed:
    - name:   /etc/apache2/sites-available/owncloud.conf
    - source: salt://data/services/owncloud/apache-vhost

    - group: root
    - user:  root
    - mode:  644

    - require:
      - file: owncloud-apache-crt
      - file: owncloud-apache-key


# Enable apache site and SSL module.
owncloud-apache-site-enable:
  cmd.run:
    - name:    a2ensite owncloud
    - creates: /etc/apache2/sites-enabled/owncloud.conf
    - require:
      - file: owncloud-apache-vhost
      - pkg:  owncloud-install

owncloud-apache-env-module:
  cmd.run:
    - name:    a2enmod env
    - creates: /etc/apache2/mods-enabled/env.load
    - require:
      - pkg: owncloud-install

owncloud-apache-headers-module:
  cmd.run:
    - name:    a2enmod headers
    - creates: /etc/apache2/mods-enabled/headers.load
    - require:
      - pkg: owncloud-install

owncloud-apache-ssl-module:
  cmd.run:
    - name:    a2enmod ssl
    - creates: /etc/apache2/mods-enabled/ssl.load
    - require:
      - pkg: owncloud-install


# Disable default site.
owncloud-apache-default-disable:
  cmd.run:
    - name: a2dissite 000-default
    - onlyif: test -e /etc/apache2/sites-enabled/000-default.conf
    - require:
      - pkg: owncloud-install


# Restart apache
owncloud-apache-restart:
  service.running:
    - name: apache2
    - watch:
      - cmd:  owncloud-apache-default-disable
      - cmd:  owncloud-apache-env-module
      - cmd:  owncloud-apache-headers-module
      - cmd:  owncloud-apache-site-enable
      - cmd:  owncloud-apache-ssl-module
      - file: owncloud-apache-vhost
      - pkg:  owncloud-install
      - pkg:  owncloud-php-cache
