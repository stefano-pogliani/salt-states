Standalone mode
===============
Salt minion supports standalone mode which is used here
to provide auto-configuration of workstations.

To use stand-alone mode copy the minion configuration from
`standolone/minion` to `/etc/salt/minion` and edit the
`id` attribute appropriately.

Also git clone this repository into `/etc/salt`
(replacing existing files if needed) so that no changes are
required between standalone and master mode.

Keep in mind that the top file for standalone mode is
`standalone/top.sls`.
