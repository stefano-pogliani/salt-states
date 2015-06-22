{% set settings = salt['pillar.get']('zabbix-frontend', {}) -%}

<?php

// Zabbix GUI configuration file
global $DB;

$DB['TYPE']     = 'MYSQL';
$DB['SERVER']   = '{{ settings.get('db-host', 'localhost') }}';
$DB['PORT']     = '{{ settings.get('db-port', '0') }}';
$DB['DATABASE'] = '{{ settings.get('db-name', 'zabbix') }}';
$DB['USER']     = '{{ settings.get('db-user', 'zabbix') }}';
$DB['PASSWORD'] = '{{ settings.get('db-pass', 'zabbix') }}';

// SCHEMA is relevant only for IBM_DB2 database
$DB['SCHEMA'] = '';

$ZBX_SERVER      = '{{ settings.get('zbx-server',      'localhost') }}';
$ZBX_SERVER_PORT = '{{ settings.get('zbx-server-port', '10051') }}';
$ZBX_SERVER_NAME = '{{ settings.get('zbx-server-name', 'Zabbix') }}';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>

