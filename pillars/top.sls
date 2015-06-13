base:
  '*':
    - base.editors.vim
    - zabbix

    # Deploy my user and public SSH key to all systems
    - base.users.allowed-users
    - base.users.stefano
    - keys.ssh.users.stefano

  'os:Debian':
    - match: grain
    - grains.debian.editors.vim
    - grains.debian.pkg_names
    - grains.debian.system

  amber:
    - amber.jenkins
    - amber.packages

    # Relevant SSH keys
    - keys.ssh.users.amber
    - keys.ssh.users.amber.private

  forest:
    - forest.allowed-users
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix

    # Relevant SSH keys
    #- keys.ssh.users.lathander
    #- keys.ssh.users.lathander.private
