jenkins:
  home: /var/lib/jenkins

jenkins-setup:
  plugins:
    - analysis-core
    - ant
    - antisamy-markup-formatter
    - cobertura
    - credentials
    - cvs
    - doxygen
    - external-monitor-job
    - git
    - git-client
    - javadoc
    - junit
    - ldap
    - mailer
    - mapdb-api
    - matrix-auth
    - matrix-project
    - maven-plugin
    - pam-auth
    - script-security
    - ssh-credentials
    - ssh-slaves
    - subversion
    - tasks
    - translation
    - warnings

  projects:
    - SnowFox

