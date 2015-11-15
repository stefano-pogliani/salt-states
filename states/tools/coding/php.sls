php-deploy-sources:
  archive.extracted:
    - name:   /opt/php-sources
    - source: salt://external/tools/php-5.6.15.tar.bz2
    - if_missing: /opt/php-sources/configure

    - archive_format: tar
    - tar_options: --strip 1


php-install-deps:
  pkg.installed:
    - pkgs:
        - apache2-prefork-dev
        - bison
        - libbz2-dev
        - libc-client2007e-dev
        - libcurl4-openssl-dev
        - libfcgi-dev 
        - libfcgi0ldbl
        - libicu-dev
        - libjpeg8-dev
        - libmcrypt-dev
        - libpspell-dev
        - libssl-dev
        - libxml2-dev
        - libzip-dev


php-configure:
  cmd.run:
    - name: >
        ./configure
        --prefix=/opt/php
        --with-config-file-path=/etc/php5/cli
        --with-config-file-scan-dir=/etc/php5/cli/conf.d
        --with-apxs2=/usr/bin/apxs2
        --with-mysql
        --with-zlib-dir
        --with-freetype-dir
        --enable-cgi
        --enable-mbstring
        --with-libxml-dir=/usr
        --enable-soap
        --enable-calendar
        --with-curl
        --with-mcrypt
        --with-zlib
        --with-gd
        --disable-rpath
        --enable-inline-optimization
        --with-bz2
        --with-zlib
        --enable-sockets
        --enable-sysvsem
        --enable-sysvshm
        --enable-pcntl
        --enable-mbregex
        --with-mhash
        --enable-zip
        --with-pcre-regex
        --with-pdo-mysql
        --with-mysqli
        --with-jpeg-dir
        --with-png-dir
        --enable-gd-native-ttf
        --with-openssl
        --with-libxml-dir
        --enable-exif
        --enable-dba
        --with-gettext
        --enable-shmop
        --enable-sysvmsg
        --with-kerberos
        --enable-bcmath
        --enable-ftp
        --enable-intl
        --with-pspell
        > configure.log

    - creates: /opt/php-sources/Makefile
    - cwd: "/opt/php-sources"

    - require:
      - archive: php-deploy-sources
      - pkg: php-install-deps

php-make:
  cmd.run:
    - name: "make > make.log"
    - creates: /opt/php-sources/sapi/cli/php
    - cwd: "/opt/php-sources"
    - require:
      - cmd: php-configure

php-make-install:
  cmd.run:
    - name: "make install > install.log"
    - creates: /opt/php/bin/php
    - cwd: "/opt/php-sources"
    - require:
      - cmd: php-make
