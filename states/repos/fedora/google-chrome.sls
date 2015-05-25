google-chrome-fedora-repo:
  pkgrepo.managed:
    - enabled
    - gpgcheck: 1
    - humanname: google-chrome
    - name: google-chrome

    - baseurl: http://dl.google.com/linux/chrome/rpm/stable/$basearch
    - gpgkey: https://dl-ssl.google.com/linux/linux_signing_key.pub
