skype-repo:
  pkgrepo.managed:
    - humanname: skype
    - name: skype

    - enabled:  1
    - gpgcheck: 1
    - skip_if_unavailable: 1

    - baseurl: http://download.skype.com/linux/repos/fedora/updates/i586/
    - gpgkey: http://www.skype.com/products/skype/linux/rpm-public-key.asc
