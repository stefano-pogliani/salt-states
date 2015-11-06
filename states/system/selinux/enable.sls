selinux-tools-install:
  pkg.installed:
    - pkgs:
        - auditd
        - selinux-utils
        - selinux-basics
        - selinux-policy-default


# SELinux is not supported by the default raspbian kernel ...
#selinux-enable:
#  cmd.run:
#    - name:   selinux-activate
#    - onlyif: sestatus
#    - require:
#      - pkg: selinux-tools-install
