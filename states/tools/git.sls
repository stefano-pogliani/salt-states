git:
  pkg.installed

git-user:
  git.config:
    - name:  user.name
    - value: Stefano Pogliani
    - is_global: True

    - require:
      - pkg: git

git-email:
  git.config:
    - name:  user.email
    - value: stefano@spogliani.net
    - is_global: True

    - require:
      - pkg: git
