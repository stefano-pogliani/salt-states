{% set opt_path = salt["pillar.get"]("node:opt_path", "/opt/node") %}

include:
  - global


# Ensure {{ opt_path }} exists.
node-opt-dir:
  file.directory:
    - name:  {{ opt_path }}
    - group: root
    - user:  root


# Unpack archive into {{ opt_path }}
node-install:
  archive.extracted:
    - name: {{ opt_path }}
    - source: salt://data/tools/iojs-bin-v2.0.2.tar.gz

    - archive_format: tar
    - tar_options: --strip 1

    - if_missing: {{ opt_path }}/bin/node
    - require:
      - file: node-opt-dir


# Add new node to path.
node-extend-path:
  path.include:
    - path: {{ opt_path }}/bin

    - require:
      - archive: node-install

    - require_in:
      - path: salt_path_profile
