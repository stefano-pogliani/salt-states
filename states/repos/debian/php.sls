php-repo:
  pkgrepo.managed:
    - name: "deb http://packages.dotdeb.org wheezy-php56 all"
    - file: /etc/apt/sources.list.d/php.list
    - key_url: salt://data/repos/debain/php.gpg
