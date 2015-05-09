base:
  '*':
    - base.editors.vim
    - base.users.stefano
    - zabbix

  amber:
    - amber.jenkins

  #forest:
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix

  'os:Debian':
    - match: grain
    - grains.debian.editors.vim
