base:
  #'*':
  #  - iptables

  #amber:
  #  - jenkins

  forest:
    - zabbix-front
    #- zabbix.agent.conf

  lathander:
    - pull-cfg
    - zabbix.agent.conf
    - zabbix.agent.repo
    - zabbix.server.conf
    - zabbix.server.repo

    # Temporarely use iptables only for one host to test it.
    - iptables

