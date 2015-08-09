grafana-add-deb-repo:
  pkgrepo.managed:
    - name: deb https://packagecloud.io/grafana/stable/debian/ wheezy main
    - dist: wheezy
    - humanname: Grafana
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: https://packagecloud.io/gpg.key


grafana-install:
  pkg.installed:
    - name: grafana
    - require:
      - pkgrepo: grafana-add-deb-repo
