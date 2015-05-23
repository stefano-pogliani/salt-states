{% for tool in ['g++', 'gcc'] %}
{{ tool }}-install:
  pkg.installed:
    - name: {{ salt['pillar.get']('pkg_names:lookup:' + tool, tool) }}
{% endfor %}
