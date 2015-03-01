pull-cfg:
  git.latest:
    - name:        "git@forest:config/salt.git"
    - remote_name: origin
    - rev:         master
    - submodules:  True
    - target:      /etc/salt

