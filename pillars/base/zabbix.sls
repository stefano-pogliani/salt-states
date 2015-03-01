# TODO(stefano): move parameters into shared variables.
# TODO(stefano): move password into a separate private repository.

zabbix-agent:
  listenip:     0.0.0.0
  listenport:   10050
  server:       lathander
  serveractive: lathander

zabbix-frontend:
  dbhost: thoth
  dbname: zabbix
  dbuser: zabbix
  dbpass: 'z8x-s3rv3r-d4t4'

  zbxserver:     lathander
  zbxserverport: 10051
  zbxservername: 'sph'

zabbix-server:
  listenip:   0.0.0.0
  listenport: 10051
  dbhost: thoth
  dbname: zabbix
  dbuser: zabbix
  dbpass: 'z8x-s3rv3r-d4t4'

