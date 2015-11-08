owncloud-repo:
  pkgrepo.managed:
    - name: "deb http://download.owncloud.org/download/repositories/stable/Debian_7.0/ /"
    - file: /etc/apt/sources.list.d/owncloud.list
    - key_url: salt://data/services/owncloud/Release.key


owncloud-install:
  pkg.latest:
    - name: owncloud
    - require:
      - pkgrepo: owncloud-repo


owncloud-mount-data:
  mount.mounted:
    - name:   /data
    - device: /dev/mmcblk0p3
    - fstype: ext4

    - mkmnt: True
    - opts:  "defaults,nosuid,noexec"


owncloud-data-create:
  file.directory:
    - name: /data/owncloud

    - group: www-data
    - user:  www-data
    - mode:  750

    - require:
      - pkg: owncloud-install


owncloud-clt-script:
  file.managed:
    - name:   /opt/spogliani/owncloud/owncloudclt
    - source: salt://data/services/owncloud/owncloudclt.sh
    - makedirs: True

    - group: www-data
    - user:  www-data
    - mode:  750


# This all require SELinux which is not available in Raspbian.
#owncloud-selinux-data:
#  cmd.run:
#    - name: |
#        semanage fcontext -a -t httpd_sys_rw_content_t '/data/owncloud'
#        restorecon '/data/owncloud'
#
#    - unless:  "test $(ls --directory --context /data/owncloud | grep -c 'httpd_sys_rw_content_t') == 1"
#    - require:
#      - file:  owncloud-data-create
#      - mount: owncloud-mount-data
#      - pkg:   owncloud-selinux-install
