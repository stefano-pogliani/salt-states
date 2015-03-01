include:
  - zabbix.binaries

zabbix-server-install:
  require:
    - sls: zabbix.binaries

zabbix-server-config:
  file.managed:
    - name:     /opt/zabbix/etc/zabbix_server.conf
    - user:     zabbix
    - group:    zabbix
    - mode:     644
    - source:   salt://data/zabbix/zabbix_server.conf
    - template: jinja

  require:
    - sls: zabbix.binaries

zabbix-server-service:
  service.running:
    - enable: True
    - name:   zabbix-server

  require:
    - file.managed: /opt/zabbix/etc/zabbix_server.conf

