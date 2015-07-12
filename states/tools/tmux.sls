{% set plugins = salt["pillar.get"]("tmux:plugins", []) %}


# Install the package.
tmux-package:
  pkg.installed:
    - name: tmux


# Copy the configuration, including all plugins.
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


# Create needed directories.
tmux-dir-etc:
  file.directory:
    - name:   /etc/tmux
    - makedirs: True
    - group: root
    - user:  root
    - mode:  755


# Copy support scripts.
tmux-scripts-check-ver:
  file.managed:
    - name:   /etc/tmux/check-ver
    - source: salt://data/editors/vim/scripts/check-ver
    - require:
      - file: tmux-dir-etc


# Deal with plugins, if any.
{% if plugins %}
# Plugins dir.
tmux-dir-puglins:
  file.directory:
    - name:   /etc/tmux/plugins
    - makedirs: True
    - group: root
    - user:  root
    - mode:  755
    - require:
      - file: tmux-dir-etc

# Plugins manager.
tmux-plugin-manager:
  git.latest:
    - name:   https://github.com/tmux-plugins/tpm
    - target: /etc/tmux/plugins/tpm
    - require:
      - file: tmux-dir-plugins

# Install plugins.
{% for plugin in salt["pillar.get"]("", []) %}
tmux-plugin-{{ plugin.name }}:
  git.latest:
    - name:   {{ plugin.repo }}
    - target: /etc/tmux/plugins/{{ plugin.name }}
    - require:
      - file: tmux-dir-plugins
      - git:  tmux-plugin-manager
{% endfor %}
{% endif %}
