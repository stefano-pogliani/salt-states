{% set opt_path = salt["pillar.get"]("node:opt_path", "/opt/node") %}

include:
  - path-profile


# Ensure {{ opt_path }} exists.
node-opt-dir:
  file.directory:
    - name:  {{ opt_path }}
    - group: root
    - user:  root


# Unpack archive into {{ opt_path }}
node-unpack:
  archive.extracted:
    - name: {{ opt_path }}
    - source: salt://data/tools/iojs-bin-v2.0.2.tar.gz

    - archive_format: tar
    - tar_options: --strip 1

    - if_missing: {{ opt_path }}/bin/node
    - require:
      - file: node-opt-dir


# Symlink stuff in /usr/bin or daemons won't find them.
# Use alternatives to manage symlinks.
{% for bin in ["node", "npm"] %}
node-alternative-{{ bin }}:
  alternatives.install:
    - name: {{ bin }}
    - link: /usr/bin/{{ bin }}
    - path: {{ opt_path }}/bin/{{ bin }}
    - priority: 100

{% endfor %}


# Add new node to path.
node-install:
  path.include:
    - path: {{ opt_path }}/bin

    - require:
      - archive: node-unpack

    - require_in:
      - path: salt_path_profile
