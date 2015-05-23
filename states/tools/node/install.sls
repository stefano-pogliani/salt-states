# Unpack archive into /opt
node-install:
  archive.extracted:
    - name: /opt/node
    - source: salt://data/tools/iojs-bin-v2.0.2.tar.gz

    - archive_format: tar
    - tar_options: --strip 1

    - if_missing: bin/node


# Add new node to path.
node-extend-path:
  path.include:
    - path: '/opt/node/bin'

    - require:
      - archive: node-install

    - require_in:
      - path: salt_path_profile
