grunt-cli-install:
  {% if salt["pillar.get"]("node:grunt:cli-from-npm") %}
  npm.installed:
    - name: grunt-cli
  {% else %}
  pkg.installed:
    - name: {{ salt["pillar.get"]("pkg_names:grunt-cli", "nodejs-grunt-cli") }}
  {% endif %}

    - require:
      - {{ salt["pillar.get"]("node:source", "pkg") }}: node-install
