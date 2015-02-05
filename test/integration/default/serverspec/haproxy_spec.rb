require 'spec_helper'

describe package('haproxy') do
  it { should be_installed }
end

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe file('/etc/haproxy/haproxy.cfg') do

  it { should be_file }
  its(:content) { should match <<CONF
global
  log 127.0.0.1   local0
  log 127.0.0.1   local1 notice
  #log loghost    local0 info
  maxconn 80000
  #debug
  #quiet
  user haproxy
  group haproxy
  stats socket /tmp/haproxy.sock
  description Global tacos.

defaults
  log             global
  mode            http
  option          httplog
  option          dontlognull
  retries         3
  option          redispatch
  maxconn        80000
  timeout client 60s             # Client and server timeout must match the longest
  timeout server 60s             # time we may wait for a response from the server.
  timeout queue  120s              # Don't queue requests too long if saturated.
  timeout connect 10s           # There's no reason to change this one.
  timeout http-request 30s	# A complete request may never take that long.
  option          httpclose                                         # disable keepalive (HAProxy does not yet support the HTTP keep-alive mode)
  option          abortonclose                                      # enable early dropping of aborted requests from pending queue
  option          httpchk                                           # enable HTTP protocol to check on servers health
  http-check disable-on-404

backend app_servers
  balance roundrobin
  option redispatch
  option httpclose
  option forwardfor
  option httpchk OPTIONS /

  reqadd X-Backend:1

  default-server port 81 inter 5s fastinter 1s fall 1
  server app-01 127.0.0.1:81 check weight 192
  server app-02 127.0.0.2:81 check weight 256
  server app-03 127.0.0.3:81 check weight 8

backend app_servers_ssl
  mode tcp
  balance roundrobin
  option redispatch
  option httpchk OPTIONS /

  reqadd X-Backend-SSL:1

  default-server port 81 inter 5s fastinter 1s fall 1
  server app-01 127.0.0.1:444 check weight 192
  server app-02 127.0.0.2:444 check weight 256
  server app-03 127.0.0.3:444 check weight 8

frontend http-in
  bind :80
  reqadd X-Frontend:1
  default_backend app_servers

frontend https-in
  mode tcp
  bind :443
  reqadd X-Frontend-SSL:1
  default_backend app_servers_ssl
CONF
  }
end
