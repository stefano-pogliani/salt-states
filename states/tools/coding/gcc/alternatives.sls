{% for tool in ['g++', 'gcc', 'gcov'] %}
{{ tool }}-46-alternative:
  alternatives.install:
    - name: {{ tool }}
    - link: /usr/bin/{{ tool }}
    - path: /usr/bin/{{ tool }}-4.6
    - priority: 406

{{ tool }}-48-alternative:
  alternatives.install:
    - name: {{ tool }}
    - link: /usr/bin/{{ tool }}
    - path: /usr/bin/{{ tool }}-4.8
    - priority: 408

{% endfor %}
