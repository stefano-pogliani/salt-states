# Install simple packages for the system.
# List of packages is found in pillar.
{% for name, require in salt["pillar.get"]("system:insall-packages", {}).iteritems() %}
pkg-install-{{ name }}:
  pkg.install:
    - name: {{ name }}

    {% if require %}
    - require:
      - {{ require }}
    {% endif %}

{% endfor %}
