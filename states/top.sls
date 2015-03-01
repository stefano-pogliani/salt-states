base:
  #'*':
  #  - iptables

  #amber:
  #  - jenkins

  #forest:
  #  - zabbix.agent.conf

  lathander:
    - pull-cfg
    #- zabbix.agent.conf
    - zabbix.server.conf

    # Temporarely use iptables only for one host to test it.
    - iptables

