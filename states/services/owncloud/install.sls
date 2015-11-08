include:
  - services.owncloud


owncloud-occ-install:
  cmd.run:
    - name: >
        ./occ list

    - onlyif: /opt/spogliani/owncloud/owncloudclt check install
    - cwd:    /var/www/owncloud
    - group:  www-data
    - user:   www-data

    - require:
      - pkg:  owncloud-install
      - file: owncloud-data-create
      - file: owncloud-clt-script
