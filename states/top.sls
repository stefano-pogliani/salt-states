base:
  '*':
    - aliases.core
    - system.at

    - editors.vim
    - editors.vim.bundles

    - ssh.keys.access
    - ssh.keys.deploy

    - tools.git
    - tools.tmux

  amber:
    - dev-tools.all
    - tools.node

    - tools.coding.gcc.install
    - tools.coding.gcc.alternatives

    - tools.coding.cppcheck
    - tools.coding.grunt
    - tools.coding.jenkins.install

    - tools.coding.protobuf
    - tools.coding.protobuf.cpp

  forest:
    - services.grafana.install

  #lathander:
  #  - iptables

  nephele:
    - services.owncloud
    - services.owncloud.apache
    - services.owncloud.install
    #- services.owncloud.secure

  thoth:
    - services.influxdb.server
    - services.mysql.server
