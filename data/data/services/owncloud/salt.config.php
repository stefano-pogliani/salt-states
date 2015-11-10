<?php

$CONFIG = array(
  {% if domains -%}
  // This is the list of domains OwnCloud is accessible from.
  // It should include the host name, the dedicated DNS and
  // any fully qualified form of the above.
  'trusted_domains' => array(
    {% for domain in domains -%}
    '{{ domain }}',
    {% endfor %}
  ),
  {% endif %}
  'max_filesize_animated_gifs_public_sharing' => 0,
  'activity_expire_days' => 30,
  'memcache.local' => '\OC\Memcache\APC',
);
