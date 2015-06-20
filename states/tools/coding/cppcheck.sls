cppckeck-install:
  pkg.installed:
    - name: {{ salt["pillar.get"]("pkg_names:lookup:cppcheck", "cppcheck") }}
