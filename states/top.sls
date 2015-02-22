base:
  'salt-node:master':
    - match: grain
    - "pull-cfg"

