salt-master:
  iptables.append:
    table: filter
    chain: INPUT
    jump:  ACCEPT
    dport: 4505
    proto: tcp
    save:  True

  iptables.append:
    table: filter
    chain: INPUT
    jump:  ACCEPT
    dport: 4506
    proto: tcp
    save:  True

