default[:haproxy][:backends] = OpsworksHaproxy::backends(node)

default[:haproxy][:custom_config][:global] = {}
default[:haproxy][:custom_config][:defaults] = {}
default[:haproxy][:custom_config][:backend] = {}
default[:haproxy][:custom_config][:backend_ssl] = {}
default[:haproxy][:custom_config][:frontend] = {}
default[:haproxy][:custom_config][:frontend_ssl] = {}
