include:
  - zabbix.binaries

zabbix-server-install:
  require:
    - sls: zabbix.binaries

zabbix-server:
  service.running:
    enable: True

