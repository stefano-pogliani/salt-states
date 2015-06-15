{% set opt_path = salt["pillar.get"]("node:opt_path", "/opt/node") %}


{% for bin in ["node", "npm"] %}
node-remove-alternative-{{ bin }}:
  alternatives.remove:
    - name: {{ bin }}
    - path: {{ opt_path }}/bin/{{ bin }}

{% endfor %}

node-remove-dir:
  file.absent:
    - name: {{ opt_path }}
