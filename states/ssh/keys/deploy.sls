# SSH key deploy state.
# Keys are stored in the pillar in a users:keys dictionary that
# maps the user name to the key information.
{% set keys = salt["pillar.get"]("users:keys", {}) %}

# For each user look up the key information.
{% for id, key in keys.iteritems() %}
{% set user = key.get("user", id) %}
{% set path = key.get("path", "/home/" + user + "/.ssh") %}

# Only deply the key if the private one is available.
{% if key.get("private") %}
{% set comment = key.public.comment %}
ssh-dir-{{ comment }}:
  file.directory:
    - makedirs: True
    - name:  {{ path }}
    - user:  {{ user }}
    - group: {{ user }}
    - mode:  700


ssh-priv-{{ comment }}:
  file.managed:
    - name: {{ path }}/{{ key.get("name", "id_rsa") }}
    - contents_pillar: "users:keys:{{ id }}:private"
    - user: {{ user }}
    - mode: 600

    - require:
      - file: ssh-dir-{{ comment }}


{% set public = key.public %}
ssh-pub-{{ comment }}:
  file.managed:
    - name: {{ path }}/{{ key.get("name", "id_rsa") }}.pub
    - contents: "{{ public.enc }} {{ public.key }} {{ comment }}"
    - user: {{ user }}
    - mode: 600

    - require:
      - file: ssh-dir-{{ comment }}

{% endif %}
{% endfor %}
