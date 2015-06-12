# SSH key deploy state.
# Keys are stored in the pillar in a users:keys dictionary that
# maps the user name to the key information.
{% set keys = salt["pillar.get"]("users:keys") %}

# For each user look up the key information.
{% for user, key in keys.iteritems() %}
{% set path = key.get("path", "/home/" + user + "/.ssh") %}

# Only deply the key if the private one is available.
{% if key.get("private") %}
"ssh-dir-{{ key.comment }}":
  file.directory:
    - name:  {{ path }}
    - user:  {{ user }}
    - group: {{ user }}
    - mode:  700


"ssh-priv-{{ key.comment }}":
  file.managed:
    - name: {{ path }}/{{ key.get("name", "id_rsa") }}
    - contents_pillar: "users:keys:{{ user }}:private"
    - user: {{ user }}
    - mode: 600

    - require:
      - file: ssh-dir-{{ key.comment }}


{% set public = salt["pillar.get"]("users:keys:" + user + ":public") %}
"ssh-pub-{{ key.comment }}":
  file.managed:
    - name: {{ path }}/{{ key.get("name", "id_rsa") }}.pub
    - contents: {{ enc }} {{ key }} {{ comment }}
    - user: {{ user }}
    - mode: 600

    - require:
      - file: ssh-dir-{{ key.comment }}

{% endif %}
{% endfor %}
