{% set id_name = salt["pillar.get"]("users:keys:stefano:name") %}

include:
  - ssh.keys.sintofan.stefano


ssh-sintofan-stefano-priv:
  file.managed:
    - name: /home/stefano/.ssh/{{ id_name }}
    - contents_pillar: "users:keys:stefano:private"
    - user:  stefano
    - group: stefano
    - mode:  700

    - require:
      - file: ssh-sintofan-stefano-dir
