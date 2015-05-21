#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulDefinition < Chef::Resource
  include Poise(fused: true)
  provides(:consul_definition)
  actions(:create, :delete)

  attribute(:path,
            kind_of: String,
            name_attribute: true,
            cannot_be: :empty)

  attribute(:id,
            kind_of: [String, NilClass],
            default: nil)
  attribute(:run_user,
            kind_of: String,
            cannot_be: :empty,
            default: 'consul')
  attribute(:run_group,
            kind_of: String,
            cannot_be: :empty,
            default: 'consul')

  action(:create) do
    file new_resource.path do
      user new_resource.run_user
      group new_resource.run_group
      mode '0600'
      content new_resource.to_json
    end
  end

  action(:delete) do
    file new_resource.path do
      action :delete
    end
  end
end
