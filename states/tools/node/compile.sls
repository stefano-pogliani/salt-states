# Fetch and unpack source code.
node-compile-fetch:
  archive.extracted:
    - name: /tmp/salt-node-source
    - source: http://nodejs.org/dist/v0.12.2/node-v0.12.2.tar.gz
    - archive_format: tar


# Configure node.
node-compile-config:
  cmd.run:
    - cwd:  /tmp/salt-node-source
    - name: './configure --prefix=/opt/node 2>&1 | tee configure.log'

    - require:
      - archive: node-compile-fetch


# Make it.
node-compile-make:
  cmd.run:
    - cwd:  /tmp/salt-node-source
    - name: 'make 2>&1 | tee make.log'

    - require:
      - cmd: node-compile-config


# Make install it.
node-compile-make-install:
  cmd.run:
    - cwd:  /tmp/salt-node-source
    - name: 'make install 2>&1 | tee make-install.log'

    - require:
      - cmd: node-compile-make

# Bundle in an archive.
node-compile-boundle:
  cmd.run:
    - cwd:  /opt
    - name: 'tar -cvf node.tar.gz ./node 2>&1 | tee /tmp/salt-node-source/archive.log'

    - require:
      - cmd: node-compile-make-install
