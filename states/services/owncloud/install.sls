include:
  - services.owncloud


owncloud-occ-install:
  cmd.run:
    - name: >
        ./occ list

    - onlyif: >
        test "$(
          ./occ list | grep -c 'ownCloud is not installed'
        )" == 1

    - cwd:   /var/www/owncloud
    - group: www-data
    - user:  www-data

    - require:
      - pkg:  owncloud-install
      - file: owncloud-data-create
