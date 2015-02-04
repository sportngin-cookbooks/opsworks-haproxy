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

  backend app_servers
  balance leastconn
  option redispatch
  option httpclose
  option forwardfor
  option httpchk /okcomputer
    server app-01 127.0.0.1:81 check port 81 inter 5000 fastinter 1000 fall 1 weight 192
    server app-02 127.0.0.2:81 check port 81 inter 5000 fastinter 1000 fall 1 weight 256
    server app-03 127.0.0.3:81 check port 81 inter 5000 fastinter 1000 fall 1 weight 8

  backend app_servers_ssl
  mode tcp
  balance leastconn
  option redispatch
  option httpchk /okcomputer
    server app-01 127.0.0.1:444 check port 81 inter 5000 fastinter 1000 fall 1 weight 192
    server app-02 127.0.0.2:444 check port 81 inter 5000 fastinter 1000 fall 1 weight 256
    server app-03 127.0.0.3:444 check port 81 inter 5000 fastinter 1000 fall 1 weight 8

frontend http-in
bind :80
  default_backend app_servers

frontend https-in
mode tcp
bind :443
  default_backend app_servers_ssl
CONF
  }
end