{% set config = salt["pillar.get"]("owncloud:server", {}) %}


include:
  - services.owncloud


owncloud-occ-install:
  cmd.run:
    - name: >
        php occ maintenance:install  \
        --no-interaction             \
        --data-dir "/data/owncloud"  \
        --admin-user "{{ config.admin.user }}"      \
        --admin-pass "{{ config.admin.password }}"  \
        --database "mysql"          \
        --database-name "owncloud"  \
        --database-host "{{ config.db.host }}"     \
        --database-user "{{ config.db.user }}"     \
        --database-pass "{{ config.db.password }}"

    - unless: /opt/spogliani/owncloud/owncloudclt check install
    - cwd:    /var/www/owncloud
    - group:  www-data
    - user:   www-data

    - require:
      - pkg:  owncloud-install
      - file: owncloud-data-create
      - file: owncloud-clt-script
