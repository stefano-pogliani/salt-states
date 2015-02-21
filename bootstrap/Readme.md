Bootstrapping Salt
==================
Use the script to quickly install the SaltStack repository.
Please note that it will also import the GPG key for
it over HTTP (not my choice).

Docs
----
http://docs.saltstack.com/en/latest/
http://docs.saltstack.com/en/latest/topics/tutorials/walkthrough.html


First config options
--------------------

### Minion config
Run `vim /etc/salt/minion` and change:

  * `master`
  *`id`

