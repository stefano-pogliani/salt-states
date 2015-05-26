{% set jenkins = salt["pillar.get"]("jenkins", {}) -%}
{% set home  = jenkins.get("home", "/var/lib/jenkins") -%}
{% set user  = jenkins.get("user", "jenkins") -%}
{% set group = jenkins.get("group", user) -%}
{% set projects = jenkins.get("projects", []) -%}


# Include install sls.
include:
  - tools.coding.jenkins.install


# Jenkins configuration.
jenkins_configuration:
  file.managed:
    - name:   {{ home }}/config.xml
    - source: salt://data/tools/coding/jenkins/config.xml

    - group: {{ group }}
    - user:  {{ user }}

    - require:
      - sls: tools.coding.jenkins.install
    - watch_in:
      - service: jenkins


# Add user configuration.
jenkins_users_stefano:
  file.managed:
    - makedirs: True
    - name:   {{ home }}/users/stefano/config.xml
    - source: salt://priv-data/tools/coding/jenkins/users/stefano/config.xml

    - group: {{ group }}
    - user:  {{ user }}

    - require:
      - sls: tools.coding.jenkins.install
    - watch_in:
      - service: jenkins


# Projects.
{% for project in projects %}
jenkins_project_{{ project }}:
  file.managed:
    - makedirs: True
    - name:   {{ home }}/jobs/{{project}}/config.xml
    - source: salt://data/tools/coding/jenkins/jobs/{{project}}/config.xml

    - group: {{ group }}
    - user:  {{ user }}

    - require:
      - sls: tools.coding.jenkins.install
    - watch_in:
      - service: jenkins

{% endfor %}
