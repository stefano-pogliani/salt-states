{% set rpmforge_free_source = salt["pillar.get"]("pkg_urls:rpmforge:free", "http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-22.noarch.rpm") %}
{% set rpmforge_nonfree_source = salt["pillar.get"]("pkg_urls:rpmforge:nonfree", "http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-22.noarch.rpm") %}


rpmfogre-fedora-22:
  pkg.installed:
    - sources:
      - {{ rpmforge_free_source }}
      - {{ rpmforge_nonfree_source }}
