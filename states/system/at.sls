at:
  pkg.installed:
    - name: at

  service.running:
    - name: atd
    - enable: True
