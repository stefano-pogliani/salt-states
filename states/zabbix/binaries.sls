# TODO(stefano): zabbix user and group.

/opt/zabbix:
  archive.extracted:
    - archive_format: tar
    - group:          zabbix
    - user:           zabbix
    - tar_options:    z
    - source: salt://data/zabbix/binaries/{{ salt['pillar.get']('zabbix:archive', 'armhf.tar.gz') }}

/etc/init.d/zabbix-agent:
  file.managed:
    - source: salt://data/zabbix/zabbix-agent
    - user:   root
    - group:  root
    - mode:   755

/etc/init.d/zabbix-server:
  file.managed:
    - source: salt://data/zabbix/zabbix-server
    - user:   root
    - group:  root
    - mode:   755

