default[:haproxy][:backends] = OpsworksHaproxy::backends(node)
default[:haproxy][:backend_port] = 81
default[:haproxy][:backend_ssl_port] = 444
default[:haproxy][:check_port] = 81
override[:haproxy][:check_interval] = '5s'
default[:haproxy][:fast_check_interval] = '1s'
default[:haproxy][:server_fall] = 1

default[:haproxy][:custom_config][:global] = {}
default[:haproxy][:custom_config][:defaults] = {}
default[:haproxy][:custom_config][:backend] = {}
default[:haproxy][:custom_config][:backend_ssl] = {}
default[:haproxy][:custom_config][:frontend] = {}
default[:haproxy][:custom_config][:frontend_ssl] = {}
