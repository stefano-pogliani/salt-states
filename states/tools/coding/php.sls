php-deploy-sources:
  archive.extracted:
    - name:   /opt/php-sources
    - source: salt://external/tools/php-5.6.15.tar.bz2

    - archive_format: tar
    - tar_options: --gzip --strip 1
    - if_missing: /opt/php
