update-salt-states:
  git.latest:
    - name:   git@git:config/salt.git
    - target: /etc/salt
    - force_checkout: True
    - force_reset: True
    - submodules: True
