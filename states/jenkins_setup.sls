include:
  - jenkins

jenkins_config:
  file.managed:
    - name:   /var/lib/jenkins/config.xml
    - source: salt://data/jenkins/config.xml

    - requires:
      - sls: jenkins
    - watch_in:
      - service: jenkins

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

