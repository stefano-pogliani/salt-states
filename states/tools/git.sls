git:
  pkg.installed


{% for (username, user) in salt['pillar.get']('users', {}).iteritems() %}
'git-user-{{ username }}':
  git.config:
    - name:  user.name
    - user:  {{ username }}
    - value: {{ user.git_name }}

    - require:
      - pkg: git

'git-email-{{ username }}':
  git.config:
    - name:  user.email
    - user:  {{ username }}
    - value: {{ user.git_email }}

    - require:
      - pkg: git
{% endfor %}
