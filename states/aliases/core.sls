common_aliases:
  file.append:
    #- group: root
    #- mode:  0644
    #- user:  root

    - name: /etc/profile.d/common_aliases.sh
    - source: salt://data/aliases/core.sh

