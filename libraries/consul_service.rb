#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulService < Chef::Resource
  include Poise(fused: true)
  provides(:consul_service)
  actions(:create, :delete, :start, :stop, :restart)

  attribute(:service_name,
            kind_of: String,
            name_attribute: true,
            cannot_be: :empty)
  attribute(:service_type,
            kind_of: [Symbol, NilClass],
            default: nil)
  attribute(:run_user,
            kind_of: String,
            cannot_be: :empty,
            default: 'consul')
  attribute(:run_group,
            kind_of: String,
            cannot_be: :empty,
            default: 'consul')

  attribute(:extra_options,
            kind_of: [Array, NilClass])

  action(:enable) do
    poise_service_user new_resource.run_user do
      group new_resource.run_group
    end

    poise_service new_resource.service_name do
      command ''
      provider new_resource.service_type
      user new_resource.run_user
    end
  end

  %i(disable start stop restart).each do |symbol|
    action(symbol) do
      poise_service new_resource.service_name do
        provider new_resource.provider
        user new_resource.run_user
        action symbol
      end
    end
  end
end
