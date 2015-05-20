g++-install:
  pkg.insalled:
    - name: {{ salt['pillar.get']('pkg_names:lookup:gpp', 'g++') }}

gcc-install:
  pkg.insalled:
    - name: {{ salt['pillar.get']('pkg_names:lookup:gcc', 'gcc') }}

gcov-install:
  pkg.insalled:
    - name: {{ salt['pillar.get']('pkg_names:lookup:gcov', 'gcov') }}
