php-deploy-sources:
  archive.extracted:
    - name:   /opt/php-sources
    - source: salt://external/tools/php-5.6.15.tar.bz2

    - archive_format: tar
    - tar_options: --strip 1
    - if_missing: /opt/php


php-install-deps:
  pkg.installed:
    - name: libxml2-dev


php-configure:
  cmd.run:
    - name: "./configure --prefix=/opt/php > configure.log"
    - creates: /opt/php/bin/php
    - cwd: "/opt/php-sources"

    - require:
      - archive: php-deploy-sources
      - pkg: php-install-deps

php-make:
  cmd.run:
    - name "make > make.log"
    - creates: /opt/php/bin/php
    - cwd: "/opt/php-sources"
    - require:
      - cmd: php-configure
