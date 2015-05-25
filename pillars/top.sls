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

  #forest:
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix
