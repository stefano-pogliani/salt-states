base:
  '*':
    #- iptables
    - ssh.keys.stefano@sintofan

  #amber:
  #  - jenkins

  forest:
    - zabbix-front
    #- zabbix.agent.conf

  lathander:
    - pull-cfg
    - zabbix.agent.conf
    - zabbix.server.conf

    # Temporarely use iptables only for one host to test it.
    - iptables

