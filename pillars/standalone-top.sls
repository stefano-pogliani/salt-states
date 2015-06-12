base:
  sintofan:
    - base.editors.vim
    - base.users.stefano

    - sintofan.editors.vim
    - sintofan.pkg_names
    - sintofan.packages

    - sintofan.openvpn

    # Allowed remote SSH users.
    - keys.ssh.users.amber
    - sintofan.allowed-keys

    # Private stuff.
    - keys.ssh.users.stefano
    - keys.ssh.users.stefano.private
    - openvpn.client.sintofan
