base:
  '*':
    - iptables

  'salt-node:master':
    - match: grain
    - pull-cfg

