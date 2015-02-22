salt-master:
  iptables.append:
    table: filter
    chain: INPUT
    jump:  ACCEPT
    dports:
      - 4505
      - 4506
    proto: tcp
    save:  True

