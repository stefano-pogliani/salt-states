# Backup over SSH streamer.
# Deploys the script onto the minion and configures
# a backup user to be able to run the script with sudo.
{% from "tools/admin/backup/map.jinja" import backup with context %}


# Ensure user exists.
backup-streamer-group:
  group.present:
    - name: {{ backup.user }}

backup-streamer-user:
  user.present:
    - name: {{ backup.user }}
    - gid_from_name: True

    - require:
      - group: backup-streamer-group


# Deploy the script (with 500 permissions).
backup-streamer-deploay:
  file.managed:
    - name:   /opt/stream-sys
    - source: salt://data/tools/admin/backup/stream-sys

    - require:
      - group: backup-streamer-group
      - user:  backup-streamer-user


# Ammend sudoers.
backup-streamer-sudoers:
  file.append:
    - name: /etc/sudoers
    - text: "{{ backup.user }} ALL=(root) NOPASSWD: /opt/stream-sys"

    - require:
      - file: backup-streamer-deploay
      - user: backup-streamer-user
