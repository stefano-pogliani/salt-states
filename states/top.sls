base:
  '*':
    #- iptables
    - ssh.keys.stefano@sintofan

  #amber:
  #  - jenkins

  forest:
    - zabbix.front

  lathander:
    - pull-cfg

    - zabbix.agent
    - zabbix.server

    # Temporarely use iptables only for one host to test it.
    - iptables

