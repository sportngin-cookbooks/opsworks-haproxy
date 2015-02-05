package 'haproxy' do
  action :install
end

include_recipe 'opsworks-haproxy::service'

service 'haproxy' do
  action [:enable, :start]
end

include_recipe 'opsworks-haproxy::configure'
