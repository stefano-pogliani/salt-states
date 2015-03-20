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
      
# Add users configuration.
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

