# opsworks-haproxy cookbook

Cookbook to install and configure HAProxy load balencer on AWS OpsWorks.

# Requirements

Supports Amazon linux on AWS OpsWorks with Chef 11.4 or 11.10.

# Usage

Include the default recipe during setup and the configure recipe in the configure event.

# Attributes

* `node[:haproxy][:backends]` - Hash of OpsWorks layer instances that you want for HAProxy backends. Defaults to instances in layers that include 'app' in the name.
* `node[:haproxy][:custom_config][:global]` - Hash of name value pairs to set in HAProxy global section.
* `node[:haproxy][:custom_config][:defaults]` - Hash of name value pairs to set in HAProxy defaults section.
* `node[:haproxy][:custom_config][:backend]` - Hash of name value pairs to set in HAProxy backend section.
* `node[:haproxy][:custom_config][:backend_ssl]` - Hash of name value pairs to set in HAProxy backend SSL section.
* `node[:haproxy][:custom_config][:frontend]` - Hash of name value pairs to set in HAProxy frontend section.
* `node[:haproxy][:custom_config][:frontend_ssl]` - Hash of name value pairs to set in HAProxy frontend SSL section.

# Recipes

* `default` - install and create haproxy.cfg
* `configure` - update haproxy.cfg
* `service` - Chef service definition
* `stop` - stop service

# Author

Author:: Sport Ngin (<platform-ops@sportngin.com>)
