base:
  '*':
    - global
    - aliases.core

    - editors.vim
    - editors.vim.bundles

    - repos.fedora.google-chrome
    - repos.fedora.rpmforge

    - ssh.keys.sintofan.stefano.priv
    - ssh.keys.sintofan.stefano.pub

    - tools.coding.grunt
    - tools.coding.gcc.install

    - tools.git
    - tools.tmux

    - tools.node.install.from_package

    # Formulas
    - openvpn.client

# TODO states:
# - dictionary for vim
# - evolution emails
# - filezilla.configure
# - firewall rules
# - ssh.github hack for work
# - kernel ratainment policy
# - printer configuration
# - netbeans (write state? http://dlc-cdn.sun.com/netbeans/8.0.2/final/bundles/)
# - netbeans.cofigure

# TODO forulas:
# - openvpn & configuration
# - texlive && packages

# TODO install:
# - chrome.plugins
# - firefox.plugins
# - skype
# - lua (& dev stuff)
