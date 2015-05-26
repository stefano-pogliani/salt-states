grunt-npm-install:
  npm.installed:
    - name: grunt-cli
    - require:
      - {{ salt["pillar.get"]("node:source", "pkg") }}: node-install
