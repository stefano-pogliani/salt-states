base:
  '*':
    - aliases.core
    - system.at

    - editors.vim
    - editors.vim.bundles

    #- iptables
    - ssh.keys.access
    - ssh.keys.deploy

    - tools.coding.gcc.install
    - tools.git
    - tools.tmux

  'os:Debian':
    - match: grain
    - tools.coding.gcc.install
    - tools.coding.gcc.alternatives

  amber:
    - dev-tools.all
    - tools.coding.grunt
    - tools.coding.jenkins.install
    - tools.node.install.from_archive

  #forest:
  #    - zabbix.front

  lathander:
    #- zabbix.agent
    #- zabbix.server

    # Temporarely use iptables only for one host to test it.
    - iptables
