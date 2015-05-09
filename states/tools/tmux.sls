tmux-package:
  pkg.installed:
    - name: tmux

tmux-conf:
  file.managed:
    - name: /etc/tmux.conf
    - source: salt://data/tools/tmux.conf

    - group: root
    - mode:  644
    - user:  root

    - require:
      - pkg: tmux
