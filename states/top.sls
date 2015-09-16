base:
  '*':
    - aliases.core
    - system.at

    - editors.vim
    - editors.vim.bundles

    - ssh.keys.access
    - ssh.keys.deploy

    - tools.coding.gcc.install
    - tools.git
    - tools.tmux

  'os:Debian':
    - match: grain
    - tools.coding.gcc.alternatives


  amber:
    - dev-tools.all
    - tools.node.install.from_archive

    - tools.coding.cppcheck
    - tools.coding.grunt
    - tools.coding.jenkins.install

    - tools.coding.protobuf
    - tools.coding.protobuf.cpp

  forest:
    - services.grafana.install

  #lathander:
  #  - iptables

  thoth:
    - services.influxdb.server
    - services.mysql.server
