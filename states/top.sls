base:
  '*':
    - aliases.core
    - editors.vim
    #- iptables
    - ssh.keys.stefano@sintofan

  amber:
    - jenkins_setup

  forest:
    - zabbix.front

  lathander:
    - pull-cfg

    - zabbix.agent
    - zabbix.server

    # Temporarely use iptables only for one host to test it.
    - iptables

