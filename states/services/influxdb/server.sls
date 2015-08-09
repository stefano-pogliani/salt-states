influxdb-server-config:
  file.managed:
    - name:   /etc/opt/influxdb/influxdb.conf
    - source: salt://data/services/influxdb/influxdb.conf

    - require:
      - pkg:  influxdb-server-install
      - file: influxdb-server-data


influxdb-server-data:
  file.directory:
    - name:  /data/influxdb
    - group: influxdb
    - user:  influxdb
    - mode:  700

    - require:
      - pkg: influxdb-server-install


influxdb-server-install:
  pkg.installed:
    - sources:
      - influxd: salt://external/services/influxdb_0.9-devel_armhf.deb


influxdb-server-service:
  service.running:
    - name: influxdb
    - enable: True
    - require:
      - pkg: influxdb-server-install
    - watch:
      - file: influxdb-server-config
