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
        - libfcgi-dev 
        - libfcgi0ldbl
        - libjpeg62-dbg
        - libmcrypt-dev
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
        --with-apxs2
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
        --with-jpeg-dir=/usr
        --with-png-dir=/usr
        --enable-gd-native-ttf
        --with-openssl
        --with-libdir=lib64
        --with-libxml-dir=/usr
        --enable-exif
        --enable-dba
        --with-gettext
        --enable-shmop
        --enable-sysvmsg
        --enable-wddx
        --with-imap
        --with-imap-ssl
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
