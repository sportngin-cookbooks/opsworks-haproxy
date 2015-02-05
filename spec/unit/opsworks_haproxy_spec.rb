require_relative '../../libraries/opsworks_haproxy'
require 'chef'

describe OpsworksHaproxy do

  before :all do
    module OpsworksUtils
      INSTANCE_TYPES = {
          "t2.small" => { :cpu => 1, :ram => 2, :storage => "EBS Only", :networking_performance => "Low to Moderate", :physical_processor => "Intel Xeon family", :clock_speed => 2.5, :intel_avx => true, :intel_avx2 => false, :intel_turbo => true, :ebs_opt => false, :enhanced_networking => false },
          "c3.8xlarge" => { :cpu => 32, :ram => 60, :storage => "2 x 320 SSD", :networking_performance => "10 Gigabit", :physical_processor => "Intel Xeon E5-2680 v2", :clock_speed => 2.8, :intel_avx => true, :intel_avx2 => false, :intel_turbo => true, :ebs_opt => false, :enhanced_networking => true }
      }
    end
  end

  before :each do
    @node = Chef::Node::ImmutableMash.new(
        {
            opsworks: {
                layers: {
                    utility: { name: "Utility", instances: { util_01: { private_ip: "127.0.0.0", instance_type: "t2.small" } } },
                    rails_app: { name: "Rails App", instances: {
                        app_01: { private_ip: "127.0.0.1", instance_type: "c3.8xlarge", elastic_ip: "127.0.0.1" },
                        app_02: { private_ip: "127.0.0.2", instance_type: "c3.8xlarge", elastic_ip: nil },
                        app_03: { private_ip: "127.0.0.3", instance_type: "t2.small", elastic_ip: nil } }
                    }
                }
            }
        })
  end

  it 'should return weighted backends' do
    backends = OpsworksHaproxy::backends(@node)

    expect(backends).to eq(@node[:opsworks][:layers][:rails_app][:instances])
  end

  it 'should resolve max cpus' do
    backends = OpsworksHaproxy::backends(@node)
    max_cpus = OpsworksHaproxy::get_max_cpus(backends)

    expect(max_cpus).to eq(32)
  end

  it 'should calculate backend weights' do
    backends = OpsworksHaproxy::backends(@node)
    weighted_backends = OpsworksHaproxy::calculate_weights(backends)

    expect(weighted_backends[:app_01][:weight]).to eq(192)
    expect(weighted_backends[:app_02][:weight]).to eq(256)
    expect(weighted_backends[:app_03][:weight]).to eq(8)
  end

end