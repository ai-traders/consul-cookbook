#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulWatch < Chef::Resource
  include Poise(fused: true)
  provides(:consul_watch)
  actions(:create, :delete)

  attribute(:watch_name,
            kind_of: String,
            name_attribute: true)
  attribute(:watch_type,
            kind_of: String,
            cannot_be: :empty,
            equal_to: %w(checks event key keyprefix service))

  attribute(:datacenter,
            kind_of: [String, NilClass],
            default: nil)
  attribute(:handler,
            kind_of: [String, NilClass],
            default: nil)
  attribute(:token,
            kind_of: [String, NilClass],
            default: nil)

  action(:create) do
    execute new_resource.command
  end

  action(:delete) do

  end
end
