# SSH key authorised keys state.
# Looks for a map of user name -> [key ids] which will specify,
# for each user on the minion, which public keys to add.
{% set keys = salt["pillar.get"]("users:keys") %}
{% set users = salt["pillar.get"]("ssh:authorised") %}

{% for local_user, authorised_ids in users.iteritems() %}
{% for authorised_id in authorised_ids %}

{% set key = keys.get(authorised_id) %}
ssh-authorise-{{ authorised_id }}-for-{{ local_user }}:
  ssh_auth.present:
    - enc:  {{ key.public.enc }}
    - name: {{ key.public.key }}
    - user: {{ local_user }}

{% endfor %}
{% endfor %}
