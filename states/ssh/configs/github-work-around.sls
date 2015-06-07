ssh-github-work-around:
  file.append:
    - name: /home/stefano/.ssh/config
    - text: |
      Host github.com
        HostName ssh.github.com
        Port 443
