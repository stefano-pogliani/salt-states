include:
  - jenkins


# Global configuration.
jenkins_config:
  file.managed:
    - name:   /var/lib/jenkins/config.xml
    - source: salt://data/jenkins/config.xml

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


# Credential stores.
jenkins_credentials:
  file.managed:
    - name:   /var/lib/jenkins/credentials.xml
    - source: salt://priv-data/jenkins/credentials.xml

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


# SSH files.
{% for f in ['id_rsa', 'id_rsa.pub', 'known_hosts'] %}
jenkins_credentials_{{f}}:
  file.managed:
    - name:   /var/lib/jenkins/.ssh/{{f}}
    - source: salt://priv-data/jenkins/ssh/{{f}}

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

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins


#jenkins_plugins:
#  jenkins_plugin.ensure:
#    - name: git_plugin
#
#    - requires:
#      - jenkins_config
#      - sls: jenkins
#
#    - watch_in:
#      - service: jenkins

