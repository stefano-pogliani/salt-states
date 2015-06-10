include:
  - global 


netbeans_802_install:
  netbeans.install:
    - version: "8.0.2"
    - require:
      - pkg: pkg-install-java-1.7.0-openjdk


# Start netbeans with nogui
# This is required because otherwise other uses of the cli
# do not terminate but hang indefinately.
netbeans_802_start:
  netbeans.start:
    - version: "8.0.2"
    - args:
      - "--nogui"

    - require:
      - netbeans: netbeans_802_install


netbeans_802_plugins:
  netbeans.pinstall:
    - version: "8.0.2"
    - names:
      - a
      - b
      - c
    - require:
      - netbeans: netbeans_802_start


# Stop netbeans after all operations are completed.
netbeans_802_stop:
  netbeans.stop:
    - version: "8.0.2"
    - require:
      - netbeans: netbeans_802_plugins
