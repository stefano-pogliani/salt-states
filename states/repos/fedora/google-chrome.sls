google-chrome-repo:
  pkgrepo.managed:
    - humanname: google-chrome
    - name: google-chrome

    - enabled:  1
    - gpgcheck: 1
    - skip_if_unavailable: 1

    - baseurl: http://dl.google.com/linux/chrome/rpm/stable/$basearch
    - gpgkey: https://dl-ssl.google.com/linux/linux_signing_key.pub
