include_attribute 'opsworks_commons::default'

rhel_arch = RUBY_PLATFORM.match(/64/) ? 'x86_64' : 'i686'
default[:haproxy][:version] = '1.4.22'
default[:haproxy][:patchlevel] = '1'
default[:haproxy][:rpm] = "haproxy-#{node[:haproxy][:version]}-#{node[:haproxy][:patchlevel]}.#{rhel_arch}.rpm"
default[:haproxy][:rpm_url] = "#{node[:opsworks_commons][:assets_url]}/packages/#{node[:platform]}/#{node[:platform_version]}/#{node[:haproxy][:rpm]}"

default[:haproxy][:stats_url] = '/haproxy?stats'
default[:haproxy][:stats_user] = 'opsworks'
default[:haproxy][:health_check_url] = '/'
default[:haproxy][:health_check_method] = 'OPTIONS'
default[:haproxy][:check_interval] = '10s'
default[:haproxy][:client_timeout] = '60s'
default[:haproxy][:server_timeout] = '60s'
default[:haproxy][:queue_timeout] = '120s'
default[:haproxy][:connect_timeout] = '10s'
default[:haproxy][:http_request_timeout] = '30s'
default[:haproxy][:global_max_connections] = '80000'
default[:haproxy][:default_max_connections] = '80000'
default[:haproxy][:retries] = '3'
default[:haproxy][:httpclose] = true
default[:haproxy][:http_server_close] = false
default[:haproxy][:stats_socket_path] = '/tmp/haproxy.sock'
default[:haproxy][:stats_socket_level] = nil # nil for default or 'user', 'operator', 'admin'

# load factors for maxcon
default[:haproxy][:maxcon_factor_rails_app] = 7
default[:haproxy][:maxcon_factor_rails_app_ssl] = 7
default[:haproxy][:maxcon_factor_php_app] = 10
default[:haproxy][:maxcon_factor_php_app_ssl] = 10
default[:haproxy][:maxcon_factor_nodejs_app] = 10
default[:haproxy][:maxcon_factor_nodejs_app_ssl] = 10
default[:haproxy][:maxcon_factor_java_app] = 10
default[:haproxy][:maxcon_factor_java_app_ssl] = 10
default[:haproxy][:maxcon_factor_static] = 15
default[:haproxy][:maxcon_factor_static_ssl] = 15
default[:haproxy][:backends] = OpsworksHaproxy::backends(node)
default[:haproxy][:backend_port] = 81
default[:haproxy][:backend_ssl_port] = 444
default[:haproxy][:check_port] = 81
default[:haproxy][:check_interval] = '5s'
default[:haproxy][:fast_check_interval] = '1s'
default[:haproxy][:server_fall] = 1
default[:haproxy][:balance] = 'roundrobin'

default[:haproxy][:custom_config][:global] = {}
default[:haproxy][:custom_config][:defaults] = {}
default[:haproxy][:custom_config][:backend] = {}
default[:haproxy][:custom_config][:backend_ssl] = {}
default[:haproxy][:custom_config][:frontend] = {}
default[:haproxy][:custom_config][:frontend_ssl] = {}
