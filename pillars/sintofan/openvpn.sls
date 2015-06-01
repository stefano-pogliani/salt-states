openvpn:
  client:
    paths:
      ca:   /etc/openvpn/gayr-ca.crt
      cert: /etc/openvpn/sintofan.crt
      conf: /etc/openvpn/spvpn.conf
      key:  /etc/openvpn/sintofan.key

    sources:
      ca: salt://priv-data/openvpn/gayr-ca.crt


    server:
      host: spddns.no-ip.biz
      port: 2309
