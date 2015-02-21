vim:
  pkg.installed

/etc/vim/vimrc:
  file.managed:
    - source: salt://data/editors/vimrc
    - mode: 644
    - user: root
    - group: root

