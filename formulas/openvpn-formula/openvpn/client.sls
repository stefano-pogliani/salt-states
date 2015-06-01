{% from "openvpn/client.jinja" import settings with context %}
{% set pkg_name = salt["pillar.get"]("openvpn:pkg_name", "openvpn") %}

include:
  - openvpn


# Certificates.
openvpn-client-certs-ca:
  file.managed:
    - name:   {{ settings.paths.ca }}
    - source: {{ settings.sources.ca }}

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   755

    - require:
      - pkg: {{ pkg_name }}

openvpn-client-certs-cert:
  file.managed:
    - name: {{ settings.paths.cert }}
    - contents_pillar: {{ settings.sources.cert }}

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   755

    - require:
      - pkg: {{ pkg_name }}

openvpn-client-certs-key:
  file.managed:
    - name: {{ settings.paths.key }}
    - contents_pillar: {{ settings.sources.key }}

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   755

    - require:
      - pkg: {{ pkg_name }}


# Configuration and scripts.
openvpn-client-config:
  file.managed:
    - name: {{ settings.paths.conf }}
    - source:   salt://openvpn/client.conf
    - template: jinja

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   644

    - context:
      server: {{ settings.server.host }}
      port:   {{ settings.server.port }}
      ca:   {{ settings.paths.ca }}
      cert: {{ settings.paths.cert }}
      key:  {{ settings.paths.key }}
      down-script: {{ settings.paths.down }}
      up-script:   {{ settings.paths.up }}

    - require:
      - pkg:  {{ pkg_name }}
      - file: openvpn-client-certs-ca
      - file: openvpn-client-certs-cert
      - file: openvpn-client-certs-key
      - file: openvpn-client-script-down
      - file: openvpn-client-script-up


openvpn-client-script-down:
  file.managed:
    - name:   {{ settings.paths.down }}
    - source: salt://openvpn/client.down

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   755

    - require:
      - pkg: {{ pkg_name }}


openvpn-client-script-up:
  file.managed:
    - name:   {{ settings.paths.up }}
    - source: salt://openvpn/client.up

    - mkdirs: True
    - user:   root
    - group:  root
    - mode:   755

    - require:
      - pkg: {{ pkg_name }}
