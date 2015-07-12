{% set plugins = salt["pillar.get"]("tmux:plugins", []) %}


# Install the package.
tmux-package:
  pkg.installed:
    - name: tmux


# Copy the configuration, including all plugins.
tmux-conf:
  file.managed:
    - name: /etc/tmux.conf
    - source: salt://data/tools/tmux/tmux.conf

    - group: root
    - mode:  644
    - user:  root

    - template: jinja
    - context:
      plugins: {{ plugins }}
      plugins_path: /etc/tmux/plugins

    - require:
      - pkg:  tmux
      - file: tmux-scripts-check-ver
      {% for plugin in plugins %}
      - git: tmux-plugin-{{ plugin.name }}
      {% endfor %}


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
    - source: salt://data/tools/tmux/check-ver
    - require:
      - file: tmux-dir-etc


# Deal with plugins, if any.
{% if plugins %}
# Plugins dir.
tmux-dir-plugins:
  file.directory:
    - name:   /etc/tmux/plugins
    - makedirs: True
    - group: root
    - user:  root
    - mode:  755
    - require:
      - file: tmux-dir-etc

# Install plugins.
{% for plugin in plugins %}
tmux-plugin-{{ plugin.name }}:
  git.latest:
    - name:   {{ plugin.repo }}
    - target: /etc/tmux/plugins/{{ plugin.name }}
    - require:
      - file: tmux-dir-plugins
{% endfor %}

{% endif %}
