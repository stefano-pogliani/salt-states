/data/www/zabbix/conf/zabbix.conf.php:
  file.managed:
    - source:   salt://data/zabbix/zabbix.conf.php
    - user:     zabbix
    - group:    zabbix
    - mode:     644
    - template: jinja

/etc/apache2/sites-available/zabbix:
  file.managed:
    - source:   salt://data/zabbix/apache2.conf
    - user:     root
    - group:    root
    - mode:     644

