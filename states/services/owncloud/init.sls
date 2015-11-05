owncloud-repo:
  pkgrepo.managed:
    - name: "deb http://download.owncloud.org/download/repositories/stable/Debian_7.0/ /"
    - file: /etc/apt/sources.list.d/owncloud.list
    - dist: stable
    - key_url: https://download.owncloud.org/download/repositories/stable/Debian_7.0/Release.key


owncloud-install:
  pkg.latest:
    - name: owncloud
    - require:
      - pkgrepo: owncloud-repo
