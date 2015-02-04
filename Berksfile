site :opscode

def opsworks_cookbook(name, branch='release-chef-11.4')
  cookbook name, github: 'aws/opsworks-cookbooks', branch: branch, rel: name
end

def sportngin_cookbook(name, branch='master')
  cookbook name, github: "sportngin-cookbooks/#{name}", branch: branch
end

def unused_cookbook(name)
  dir = '.unused-cookbook'
  Dir.mkdir(dir) unless Dir.exist?(dir)
  File.open("#{dir}/metadata.rb", 'w') {} unless File.exist?("#{dir}/metadata.rb")
  cookbook name, path: dir
end

opsworks_cookbook 'opsworks_commons'
opsworks_cookbook 'haproxy'

unused_cookbook 'dependencies'

sportngin_cookbook 'opsworks-utils'

metadata
