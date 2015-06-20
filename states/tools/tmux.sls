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
      - pkg:  tmux
      - file: tmux-scripts-check-ver

tmux-scripts:
  file.directory:
    - name:   /etc/tmux
    - makedirs: True
    - group: root
    - user:  root
    - mode:  755

tmux-scripts-check-ver:
  file.managed:
    - name:   /etc/tmux/check-ver
    - source: salt://data/editors/vim/scripts/check-ver
    - require:
      - file: tmux-scripts
