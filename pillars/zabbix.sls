# TODO(stefano): move parameters into shared variables.
# TODO(stefano): move password into a separate private repository.

zabbix-agent:
  listen-ip:     0.0.0.0
  listen-port:   10050
  server:        {{ salt['dnsutil.A']('lathander')[0] }}
  server-active: {{ salt['dnsutil.A']('lathander')[0] }}

zabbix-frontend:
  db-host: thoth
  db-name: zabbix
  db-user: zabbix
  db-pass: 'z8x-s3rv3r-d4t4'

  zbx-server:     lathander
  zbx-server-port: 10051
  zbx-server-name: 'sph'

zabbix-server:
  listen-ip:   0.0.0.0
  listen-port: 10051
  db-host: thoth
  db-name: zabbix
  db-user: zabbix
  db-pass: 'z8x-s3rv3r-d4t4'

