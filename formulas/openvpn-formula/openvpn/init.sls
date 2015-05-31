openvpn_package:
  pkg.installed:
    - name: {{ salt["pillar.get"]("openvpn:pkg_name", "openvpn") }}
