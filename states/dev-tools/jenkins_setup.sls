{% set settings = salt['pillar.get']('jenkins-setup', {}) -%}

include:
  - jenkins


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
    - mode:  0600

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins

{% endfor %}


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

