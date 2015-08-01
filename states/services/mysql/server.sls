{% set pkg_name = salt["pillar.get"](
    "pkg_names:lookup:mysql-server", "mysql-server"
) %}


mysql-server-install:
  pkg.installed:
    - name: {{ pkg_name }}


mysql-server-config:
  file.managed:
    - name:   /etc/mysql/my.cnf
    - source: salt://data/services/mysql/my.cnf
    - group:  mysql
    - user:   mysql
    - mode:   644

    - require:
      - pkg:  mysql-server-install
      - file: mysql-server-data


mysql-server-data:
  file.directory:
    - name:  /data/mysql
    - group: mysql
    - user:  mysql
    - mode:  700

    - require:
      - pkg: mysql-server-install


mysql-server-service:
  service.running:
    - name: mysql
    - enable: True
    - require:
      - pkg: mysql-server-install
    - watch:
      - file: mysql-server-config
