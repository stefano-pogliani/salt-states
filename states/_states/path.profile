# PATH extention script.
# Generated unsing saltstack.

{% for path in accumulator['salt-path-accumulator] %}
PATH=$PATH:{{path}}
{% endfor %}

export PATH
