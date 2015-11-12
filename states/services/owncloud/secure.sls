owncloud-secure-deploy:
  file.managed:
    - name: /opt/spogliani/owncloud/secure.sh
    - source: salt://data/services/owncloud/secure.sh
    - makedirs: True

    - group: root
    - user:  root
    - mode:  750

owncloud-secure:
  cmd.run:
    - name: /opt/spogliani/owncloud/secure.sh
    - require:
      - file: owncloud-secure-deploy
