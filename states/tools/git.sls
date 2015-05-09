git:
  pkg.installed


{% for user in pillar.get('git:users', []) %}
'git-user-{{ user.unix-name }}':
  git.config:
    - name:  user.name
    - user:  {{ user.unix-name }}
    - value: {{ user.git-name }}

    - require:
      - pkg: git

'git-email-{{ user.unix-name }}':
  git.config:
    - name:  user.email
    - user:  {{ user.unix-name }}
    - value: {{ user.git-email }}

    - require:
      - pkg: git
{% endfor %}
