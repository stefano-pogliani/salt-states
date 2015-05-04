{% from "editors/vim/defaults.jinja" import vim with context %}

vim:
  pkg.installed:
    - name: {{ vim.pkg }}

vimrc:
  file.managed:
    - name: {{ vim.paths.vimrc }}
    - source: salt://data/editors/vim/vimrc

    - group: root
    - mode:  644
    - user:  root

vim-pathogen:
  file.managed:
    - name: {{ vim.paths.autoload }}/pathogen.vim
    - source: salt://data/editors/vim/pathogen.vim

    - group: root
    - mode:  644
    - user:  root
