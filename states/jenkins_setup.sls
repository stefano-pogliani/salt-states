jenkins_config:
  file.managed:
    - name:   /var/lib/jenkins/config.xml
    - source: salt://data/jenkins/config.xml

  requires:
    - sls: jenkins

  watch_in:
    - service: jenkins


jenkins_plugins:
  jenkins_plugin.ensure:
    - name: git_plugin

  requires:
    - jenkins_config
    - sls: jenkins

  watch_in:
    - service: jenkins

