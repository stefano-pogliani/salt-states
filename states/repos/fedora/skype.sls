# From http://negativo17.org/repos/fedora-skype.repo
skype-repo:
  pkgrepo.managed:
    - humanname: Skype Repository
    - name: skype

    - enabled:  1
    - gpgcheck: 1
    - skip_if_unavailable: 1

    - baseurl: http://negativo17.org/repos/skype/fedora-$releasever/$basearch/
    - gpgkey: http://negativo17.org/repos/RPM-GPG-KEY-slaanesh
