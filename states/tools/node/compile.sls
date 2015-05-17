# Fetch and unpack source code.
node-compile-fetch:
  archive.extracted:
    - name: /tmp/salt-node-source
    - source: salt://data/tools/node-v0.12.2.tar.gz

    # Configure archive extraction.
    - archive_format: tar
    - tar_options: --strip 1

    # Ensure archive is always extracted.
    - if_missing: some-file-that-does-not-make-sense


# Configure node.
node-compile-config:
  builders.configure:
    - name: /tmp/salt-node-source
    - options:
      prefix: /opt/node

    - require:
      - archive: node-compile-fetch

#  cmd.run:
#    - cwd:  /tmp/salt-node-source
#    - name: './configure --prefix=/opt/node --without-snapshot 2>&1 > configure.log'
#
#    - require:
#      - archive: node-compile-fetch


# Make it.
node-compile-make:
  cmd.run:
    - cwd:  /tmp/salt-node-source
    - name: 'make 2>&1 > make.log'

    - require:
      - cmd: node-compile-config


# Make install it.
node-compile-make-install:
  cmd.run:
    - cwd:  /tmp/salt-node-source
    - name: 'make install 2>&1 > make-install.log'

    - require:
      - cmd: node-compile-make

# Bundle in an archive.
node-compile-boundle:
  cmd.run:
    - cwd:  /opt
    - name: 'tar -cvf node.tar.gz ./node 2>&1 > /tmp/salt-node-source/archive.log'

    - require:
      - cmd: node-compile-make-install
