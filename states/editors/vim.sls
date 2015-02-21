vim:
  pkg.installed

/etc/vimrc:
  file.managed:
    - source: salt://editors/vimrc
    - mode: 644
    - user: root
    - group: root

