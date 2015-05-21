require 'spec_helper'

describe_recipe 'consul::default' do
  context 'with default attributes' do
    it do
      expect(chef_run).to create_consul_client('consul')
        .with(binary_url: '')
        .with(binary_checksum: '')
        .with(binary_version: '')
    end

    it do
      expect(chef_run).to create_consul_config('/etc/consul/default.json')
        .with(owner: 'consul')
        .with(group: 'consul')
    end

    it do
      expect(chef_run).to create_consul_service
        .with(run_user: 'consul')
        .with(run_group: 'consul')
    end

    it 'converges successfully' do
      chef_run
    end
  end
end
