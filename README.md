# opsworks-haproxy cookbook

Cookbook to install and configure HAProxy load balencer on AWS OpsWorks.

# Requirements

Supports Amazon linux on AWS OpsWorks with Chef 11.4 or 11.10.

# Usage

Include the default recipe during setup and the configure recipe in the configure event.

# Attributes

* `node[:haproxy][:backends]` - Hash of OpsWorks layer instances that you want for HAProxy backends. Defaults to instances in layers that include 'app' in the name.

# Recipes

* `default` - install and create haproxy.cfg
* `configure` - update haproxy.cfg
* `service` - Chef service definition
* `stop` - stop service

# Author

Author:: Sport Ngin (<platform-ops@sportngin.com>)
