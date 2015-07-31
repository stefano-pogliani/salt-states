{% set settings = salt["pillar.get"]("pkg_names:lookup:mysql-server") %}


mysql-server-install:
  pkg.installed:
    - name: {{ pkgs.get("mysql-server", "mysql-server") }}
