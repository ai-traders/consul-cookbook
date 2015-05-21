require 'spec_helper'

describe_recipe 'consul::ui' do
  context 'with default attributes' do
    it do
      expect(chef_run).to create_consul_client('consul-ui')
        .with(binary_url: '')
        .with(binary_checksum: '')
        .with(binary_version: '')
    end

    it 'converges successfully' do
      chef_run
    end
  end
end
