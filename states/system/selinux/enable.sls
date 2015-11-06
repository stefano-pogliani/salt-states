selinux-tools-install:
  pkg.installed:
    - name: selinux-utils


selinux-enable:
  selinux.mode:
    - name: enforcing
    - require:
      - pkg: selinux-tools-install
