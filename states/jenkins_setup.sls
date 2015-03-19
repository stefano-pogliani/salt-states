{% set settings = salt['pillar.get']('jenkins-setup', {}) -%}


include:
  - jenkins


# Global configuration.
jenkins_config:
  file.managed:
    - name:   /var/lib/jenkins/config.xml
    - source: salt://data/jenkins/config.xml

    - group: jenkins
    - user:  jenkins

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


# Credential stores.
jenkins_credentials:
  file.managed:
    - name:   /var/lib/jenkins/credentials.xml
    - source: salt://priv-data/jenkins/credentials.xml

    - group: jenkins
    - user:  jenkins

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


# SSH files.
{% for f in ['id_rsa', 'id_rsa.pub', 'known_hosts'] %}
jenkins_credentials_{{f}}:
  file.managed:
    - makedirs: True
    - name:     /var/lib/jenkins/.ssh/{{f}}
    - source:   salt://priv-data/jenkins/ssh/{{f}}

    - group: jenkins
    - user:  jenkins

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins

{% endfor %}



jenkins_users_stefano:
  file.managed:
    - makedirs: True
    - name:     /var/lib/jenkins/users/stefano/config.xml
    - source:   salt://priv-data/jenkins/users/stefano/config.xml

    - group: jenkins
    - user:  jenkins

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


# Install and update plugins
{% for plugin in settings.get('plugins', []) %}
jenkins_plugins_{{plugin}}:
  jenkins_plugin.ensure:
    - name: {{plugin}}

    - requires:
      - jenkins_config
      - sls: jenkins
    - watch_in:
      - service: jenkins

{% endfor %}


# Add projects
{% for project in settings.get('projects', []) %}
jenkins_project_{{project}}:
  file.managed:
    - makedirs: True
    - name:     /var/lib/jenkins/jobs/{{project}}/config.xml
    - source:   salt://data/jenkins/jobs/{{project}}/config.xml

    - group: jenkins
    - user:  jenkins

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins

{% endfor %}

