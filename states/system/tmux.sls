tmux-package:
  pkg.installed:
    - name: tmux

tmux-config:
  file.managed:
    - name: /etc/tmux.conf
    - source://salt/data/system/tmux.conf

    - group: root
    - mode:  644
    - user:  root

    - require:
      - pkg: tmux
