{% from "editors/vim/defaults.jinja" import vim with context %}

{{ vim.paths.bundles }}:
  file.directory


{% for bundle in salt['pillar.get']('vim:bundles', []) %}
vim-bundle-{{ bundle.name }}:
  git.latest:
    - name: {{ bundle.repo }}
    - target: {{ vim.paths.bundles }}/{{ bundle.name }}
    - require:
      - file: {{ vim.paths.bundles }}
{% endfor %}
