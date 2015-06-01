{% set id_name = salt["pillar.get"]("users:keys:stefano:name", "id_rsa") %}

include:
  - ssh.keys.sintofan.stefano


ssh-sintofan-stefano-pub:
  file.managed:
    - name: /home/stefano/.ssh/{{ id_name }}.pub
    - contents_pillar: "users:keys:stefano:public"
    - user:  stefano
    - group: stefano
    - mode:  600

    - require:
      - file: ssh-sintofan-stefano-dir
