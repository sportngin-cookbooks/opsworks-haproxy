package 'haproxy' do
  action :install
end

include_recipe 'haproxy::service'

service 'haproxy' do
  action [:enable, :start]
end

include_recipe 'haproxy::configure'
