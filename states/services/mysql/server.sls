{% set pkg_name = salt["pillar.get"](
    "pkg_names:lookup:mysql-server", "mysql-server"
) %}


mysql-server-install:
  pkg.installed:
    - name: {{ pkg_name }}
