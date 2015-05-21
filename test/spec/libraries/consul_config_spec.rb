require 'spec_helper'

describe_resource 'consul_config' do
  context 'with default attributes' do
    let(:cookbook_name) { 'consul::default' }

    it do
      expect(chef_run).to create_directory('/etc/consul.d')
        .with(owner: 'consul')
        .with(group: 'consul')
    end

    it do
      expect(chef_run).to create_file('/etc/consul.d/default.json')
        .with(owner: 'consul')
        .with(group: 'consul')
    end

    it 'converges successfully' do
      chef_run
    end
  end
end
