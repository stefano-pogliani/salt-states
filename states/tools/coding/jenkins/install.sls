{% set jenkins = salt["pillar.get"]("jenkins", {}) -%}
{% set home  = jenkins.get("home", "/var/lib/jenkins") -%}
{% set user  = jenkins.get("user", "jenkins") -%}
{% set group = jenkins.get("group", user) -%}
{% set plugins = jenkins.get("plugins", []) -%}


# Include main formula state.
include:
  - jenkins


# Credential stores.
jenkins_credentials:
  file.managed:
    - name:   /var/lib/jenkins/credentials.xml
    - source: salt://priv-data/tools/coding/jenkins/credentials.xml

    - group: {{ group }}
    - user:  {{ user }}

    - require:
      - pkg: jenkins
    - watch_in:
      - service: jenkins


# SSH files.
# Added by pillar top and ssh.depoy as all other keys.
{#
{% for name in ['id_rsa', 'id_rsa.pub', 'known_hosts'] %}
jenkins_credentials_{{ name }}:
    file.managed:
      - makedirs: True
    - name:     {{ home }}/.ssh/{{ name }}
    - source:   salt://priv-data/tools/coding/jenkins/ssh/{{ name }}

    - group: {{ group }}
    - user:  {{ user }}
    - mode:  0600

    - require:
      - pkg: jenkins
    - watch_in:
      - service: jenkins

{% endfor %}
#}


# Install/update plugins
jenkins_plugins_mkdir:
  file.directory:
    - name: "{{ home }}/plugins"
    - group: {{ group }}
    - user:  {{ user}}
    - require:
      - pkg: jenkins

{% for plugin in plugins %}
jenkins_plugins_{{ plugin }}:
  jenkins_plugin.ensure:
    - name: {{ plugin }}
    - require:
      - file: jenkins_plugins_mkdir
    - watch_in:
      - service: jenkins

{% endfor %}
