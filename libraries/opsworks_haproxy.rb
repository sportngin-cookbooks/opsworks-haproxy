module OpsworksHaproxy

  def self.backends(node)
    instances = Mash.new
    node[:opsworks][:layers].each do |layer, attributes|
      instances.merge!(attributes[:instances]) if layer.to_s.include?("app")
    end
    set_default_instance(node[:opsworks][:instance], instances)
    calculate_weights(instances)
  end

  def self.get_max_cpus(backends)
    cpus = backends.collect do |name, attrs|
      type = attrs[:instance_type]
      OpsworksUtils::INSTANCE_TYPES[type][:cpu]
    end
    cpus.max
  end

  def self.calculate_weights(backends)
    backends = to_mutatable_hashes(backends)
    max_cpus = get_max_cpus(backends)
    multiplier = (256 / max_cpus).floor
    backends.each do |name, attrs|
      weight = multiplier * OpsworksUtils::INSTANCE_TYPES[attrs[:instance_type]][:cpu]
      weight = (weight * 0.75).floor if attrs[:elastic_ip]
      attrs[:weight] = weight
    end
    backends
  end

  def self.to_mutatable_hashes(backends)
    mutable_backends = Mash.new
    backends.each do |name, attrs|
      mutable_backends[name] = attrs.to_hash
    end
    mutable_backends
  end

  def self.set_default_instance(current_instance, instances)
    if instances.empty?
      instances[current_instance[:hostname]] = current_instance.to_hash
    end
  end

  def self.default_server_params(node)
    params = []
    params << "port #{node[:haproxy][:check_port]}"
    params << "inter #{node[:haproxy][:check_interval]}"
    params << "fastinter #{node[:haproxy][:fast_check_interval]}"
    params << "fall #{node[:haproxy][:server_fall]}"
    params.join(' ')
  end

end
