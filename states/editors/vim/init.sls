{% from "editors/vim/defaults.jinja" import vim with context %}

vim:
  pkg.installed:
    - name: {{ vim.pkg }}

vimrc:
  file.managed:
    - name: {{ vim.paths.custom_vimrc }}
    - source: salt://data/editors/vim/vimrc
    - makedirs: True

    - group: root
    - mode:  644
    - user:  root

    - require:
      - pkg:  {{ vim.pkg }}
      - file: vim-pathogen

vimrc-patch:
  file.append:
    - makedirs: True
    - name: {{ vim.paths.vimrc }}
    - text: 'source {{ vim.paths.custom_vimrc }}'

    - require:
      - file: vimrc

vim-pathogen:
  file.managed:
    - name: {{ vim.paths.autoload }}/pathogen.vim
    - source: salt://external/editors/vim/pathogen.vim
    - makedirs: True

    - group: root
    - mode:  644
    - user:  root

    - require:
      - pkg: {{ vim.pkg }}
