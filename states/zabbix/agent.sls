include:
  - zabbix.binaries

zabbix-agent-config:
  file.managed:
    - name:     /opt/zabbix/etc/zabbix_agentd.conf
    - user:     zabbix
    - group:    zabbix
    - mode:     644
    - source:   salt://data/zabbix/zabbix_agentd.conf
    - template: jinja

  require:
    - sls: zabbix.binaries

zabbix-agent-service:
  service.running:
    - enable: True
    - name:   zabbix-agent

  require:
    - file.managed: /opt/zabbix/etc/zabbix_agentd.conf

