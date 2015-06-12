# SSH key authorised keys state.
# Looks for a map of user -> user which will specify,
# for each user on the minion, which public keys to add.
{% set keys = salt["pillar.get"]("users:keys") %}
{% set users = salt["pillar.get"]("ssh:authorised") %}

{% for local_user, authorised_users in users.iteritems() %}
{% for authorised_user in authorised_users %}

{% set key = keys.get(authorised_user) %}
ssh-authorise-{{ authorised_user }}-for-{{ local_user }}:
  ssh_auth.present:
    - enc:  {{ key.public.enc }}
    - name: {{ key.public.key }}
    - user: {{ local_user }}

{% endfor %}
{% endfor %}
