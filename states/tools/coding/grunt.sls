grunt-npm-install:
  npm.installed:
    - name: grunt-cli
    - require:
      {% if salt["pillar.get"]("node:source", "pkg") == "pkg" %}
      - pkg: node-install
      {% else %}
      - archive: node-install
      {% endif %}
