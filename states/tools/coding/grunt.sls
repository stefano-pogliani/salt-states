include:
  - tools.node


grunt-cli-install:
  npm.installed:
    - name: grunt-cli
    - require:
      - alternatives: node-alternative-npm
