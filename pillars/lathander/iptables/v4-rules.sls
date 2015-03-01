tables:
  - filter:
    chains:
      - INPUT:
        default: DROP
    rules:
      - "-A INPUT -i lo -j ACCEPT"
      - "-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT"

