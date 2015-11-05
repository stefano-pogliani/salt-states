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
