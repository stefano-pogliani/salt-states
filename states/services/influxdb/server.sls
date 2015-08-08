influxdb-server-install:
  pkg.installed:
    - sources:
      - influxd: salt://external/services/influxdb_0.9-devel_armhf.deb
