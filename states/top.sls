base:
  '*':
    - aliases.core
    - system.at

    - editors.vim
    - editors.vim.bundles

    #- iptables
    - ssh.keys.stefano@sintofan

    - tools.coding.gcc.install
    - tools.git
    - tools.tmux

  'os:Debian':
    - match: grain
    #Broken: - tools.coding.gcc.alternatives

  amber:
    - dev-tools.all
    - dev-tools.jenkins_setup
    - tools.node.install.from_archive
    - tools.coding.grunt

  forest:
    - zabbix.front

  lathander:
    - zabbix.agent
    - zabbix.server

    # Temporarely use iptables only for one host to test it.
    - iptables
