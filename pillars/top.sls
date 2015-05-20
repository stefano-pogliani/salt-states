base:
  '*':
    - base.editors.vim
    - base.users.stefano
    - zabbix

  'os:Debian':
    - match: grain
    - grains.debian.pkg_names
    - grains.debian.editors.vim

  amber:
    - amber.jenkins

  #forest:
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix
