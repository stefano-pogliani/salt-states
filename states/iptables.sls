/etc/iptables/iptables.rules:
  file.managed:
    - source:   salt://data/iptables/iptables.rules
    - user:     root
    - group:    root
    - mode:     644
    - template: jinja
    - makedirs: True

