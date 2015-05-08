base:
  '*':
    - zabbix

  amber:
    - amber.jenkins

  #forest:
  #  - forest.zabbix

  lathander:
    #- lathander.iptables.v4-rules
    - lathander.zabbix

  'os:Debian':
    - match: grains
    - grains.debian.vim
