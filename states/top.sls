base:
  '*':
    - aliases.core
    - editors.vim
    - editors.vim.bundles

    #- iptables
    - ssh.keys.stefano@sintofan

    - system.at
    - tools.git
    - tools.tmux

  amber:
    - dev-tools.all
    - dev-tools.jenkins_setup

  forest:
    - zabbix.front

  lathander:
    - zabbix.agent
    - zabbix.server

    # Temporarely use iptables only for one host to test it.
    - iptables
