grunt-npm-install:
  npm.installed:
    - name: grunt
    - require:
      - pkg: node-install
      - archive: node-install
