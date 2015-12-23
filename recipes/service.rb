service "haproxy" do
  supports :restart => true, :status => true, :reload => true
  action :nothing # only define so that it can be restarted if the config changed
end
service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing # only define so that it can be restarted if the config changed
end
