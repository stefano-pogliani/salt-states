base:
  '*':
    - base.editors.vim
    - base.users.stefano
    - zabbix

  'os:Debian':
    - match: grain
    - grains.debian.editors.vim
    - grains.debian.pkg_names
    - grains.debian.system

  amber:
    - amber.jenkins
    - keys.ssh.users.root.amber
    - keys.ssh.users.root.amber.private

  #forest:
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix
    - keys.ssh.users.root.lathander
    - keys.ssh.users.root.lathander.private
