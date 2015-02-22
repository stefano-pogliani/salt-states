base:
  'salt-node:master':
    - match: grain
    - pull-cfg
    - iptables.salt-master

