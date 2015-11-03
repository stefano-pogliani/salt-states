grafana-get-deb:
  file.managed:
    - name: /tmp/
    - dist: wheezy
    - humanname: Grafana
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packagecloud.io/gpg.key
    - refresh_db: True

    - require:
      - pkg: grafana-ensure-aptget-https


grafana-install:
  pkg.installed:
    - name: grafana
    - require:
      - pkgrepo: grafana-add-deb-repo
