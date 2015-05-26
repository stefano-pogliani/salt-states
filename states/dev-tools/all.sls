include:
  #- dev-tools.gcc-4-8
  - dev-tools.glibs
  - dev-tools.lua

dev_tools_all:
  cmd.run:
    - name: /bin/echo
    - require:
      #- sls: dev-tools.gcc-4-8
      - sls: dev-tools.glibs
      - sls: dev-tools.lua

