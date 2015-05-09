ssh-key-stefano@sintofan-stefano:
   ssh_auth.present:
     - user:   stefano
     - source: salt://data/ssh/keys/stefano@sintofan.pub
