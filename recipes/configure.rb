include_recipe 'haproxy::service'

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables({
                :backends => OpsworksHaproxy::calculate_weights(node[:haproxy][:backends]),
                :custom_config => node[:haproxy][:custom_config]
            })
  notifies :reload, 'service[haproxy]'
end

execute "echo 'checking if HAProxy is not running - if so start it'" do
  not_if 'pgrep haproxy'
  notifies :start, 'service[haproxy]'
end