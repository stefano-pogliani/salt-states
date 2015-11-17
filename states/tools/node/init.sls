{% set DEFAULT_ARCHIVE  = "https://nodejs.org/dist/v5.1.0/node-v5.1.0-linux-x64.tar.gz" %}
{% set DEFAULT_CHECKSUM = "https://nodejs.org/dist/v5.1.0/SHASUMS256.txt" %}

{% set conf      = salt["pillar.get"]("node", {}) %}
{% set opt_path  = conf.get("opt_path", "/opt/node") %}
{% set archive   = conf.get("archive", DEFAULT_ARCHIVE) %}
{% set checksums = conf.get("checksums", DEFAULT_CHECKSUM) %}


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
    - source: {{ archive }}
    - source_hash: {{ checksums }}

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
    - require:
      - archive: node-unpack

{% endfor %}
