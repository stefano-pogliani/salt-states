{% from "editors/vim/defaults.jinja" import vim with context %}

vim:
  pkg.installed:
    - name: {{ vim.pkg }}

vimrc:
  file.managed:
    - name: {{ vim.paths.vimrc }}
    - source: salt://data/editors/vimrc
    - mode: 644
    - user: root
    - group: root
