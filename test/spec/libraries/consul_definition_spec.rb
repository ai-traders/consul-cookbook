require 'spec_helper'

describe_resource 'consul_definition' do
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
