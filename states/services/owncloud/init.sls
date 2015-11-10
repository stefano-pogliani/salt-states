include:
  - services.mysql.saltctl


owncloud-repo:
  pkgrepo.managed:
    - name: "deb http://download.owncloud.org/download/repositories/stable/Debian_7.0/ /"
    - file: /etc/apt/sources.list.d/owncloud.list
    - key_url: salt://data/services/owncloud/Release.key


owncloud-install:
  pkg.latest:
    - name: owncloud
    - require:
      - pkgrepo: owncloud-repo

owncloud-php-cache:
  pkg.latest:
    - name: php-apc

owncloud-mount-data:
  mount.mounted:
    - name:   /data
    - device: /dev/mmcblk0p3
    - fstype: ext4

    - mkmnt: True
    - opts:  "defaults,nosuid,noexec"


owncloud-data-create:
  file.directory:
    - name: /data/owncloud

    - group: www-data
    - user:  www-data
    - mode:  750

    - require:
      - pkg: owncloud-install
      - pkg: owncloud-php-cache


owncloud-clt-script:
  file.managed:
    - name:   /opt/spogliani/owncloud/owncloudctl
    - source: salt://data/services/owncloud/owncloudclt.sh
    - makedirs: True

    - group: www-data
    - user:  www-data
    - mode:  750


{% set db = salt["pillar.get"]("mysql:thoth") %}
{% set dbpwd = salt["pillar.get"]("owncloud:server:db:password") %}
owncloud-db-ensure:
  mysql_database.present:
    - name: owncloud
    - connection_host: {{ db.host }}
    - connection_user: {{ db.user }}
    - connection_pass: {{ db.password }}

    - require:
      - pkg: mysql-saltctl-python-mysqldb-install


owncloud-dbuser-ensure:
  mysql_user.present:
    - name: owncloud
    - host: nephele.sph
    - password: {{ dbpwd }}

    - connection_host: {{ db.host }}
    - connection_user: {{ db.user }}
    - connection_pass: {{ db.password }}

    - require:
      - pkg: mysql-saltctl-python-mysqldb-install


owncloud-dbuser-grant-all:
  mysql_grants.present:
    - database: "owncloud.*"
    - grant: "all privileges"

    - user: owncloud
    - host: nephele.sph

    - connection_host: {{ db.host }}
    - connection_user: {{ db.user }}
    - connection_pass: {{ db.password }}

    - require:
      - mysql_database: owncloud-db-ensure
      - mysql_user: owncloud-dbuser-ensure
