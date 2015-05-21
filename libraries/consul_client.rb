#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::ConsulClient < Chef::Resource
  include Poise(fused: true)
  provides(:consul_client)
  actions(:create, :delete)

  attribute(:install_path,
            kind_of: String,
            name_attribute: true,
            required: true)

  attribute(:install_method,
            kind_of: String,
            default: 'binary',
            cannot_be: :empty)
  attribute(:package_name,
            kind_of: String,
            cannot_be: :empty)
  attribute(:package_version,
            kind_of: String,
            cannot_be: :empty)
  attribute(:binary_url,
            kind_of: String,
            cannot_be: :empty)
  attribute(:binary_version,
            kind_of: String,
            cannot_be: :empty)
  attribute(:source_url,
            kind_of: String,
            cannot_be: :empty)
  attribute(:source_version,
            kind_of: String,
            cannot_be: :empty)

  # SHA256 checksum value for binary installations.
  # @return [String]
  def binary_checksum
    arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : '386'
    checksum = [node['consul']['version'], node['os'], arch].join('_')
    node['consul']['checksums'].fetch(checksum)
  end

  action(:create) do
    package new_resource.package_name do
      version new_resource.package_version if new_resource.package_version
      only_if { new_resource.install_method == 'package' }
    end

    libartifact_file "consul-#{new_resource.binary_version}" do
      artifact_name 'consul'
      artifact_version new_resource.binary_version
      remote_url new_resource.binary_url
      remote_checksum new_resource.binary_checksum
      only_if { new_resource.install_method == 'binary' }
    end

    if new_resource.install_method == 'source'
      include_recipe 'golang::default'

      source_dir = directory ::File.join(new_resource.install_path, 'src') do
        recursive true
      end

      git ::File.join(source_dir.path, "consul-#{new_resource.source_version}") do
        repository new_resource.source_url
        reference new_resource.source_version
        action :checkout
      end

      golang_package 'github.com/hashicorp/consul' do
        action :install
      end

      directory ::File.join(new_resource.install_path, 'bin')

      link ::File.join(new_resource.install_path, 'bin', 'consul') do
        to ::File.join(source_dir.path, "consul-#{new_resource.source_version}", 'consul')
      end
    end
  end

  action(:delete) do
    package new_resource.package_name do
      action :remove
      only_if { new_resource.install_method == 'package' }
    end

    libartifact_file "consul-#{new_resource.binary_version}" do
      artifact_name 'consul'
      artifact_version new_resource.binary_version
      action :delete
      only_if { new_resource.install_method == 'binary' }
    end

    if new_resource.install_method == 'source'
      directory new_resource.path do
        action :delete
      end

      directory Dir.dirname(new_resource.filename) do
        action :delete
      end

      link ::File.join(new_resource.path, 'consul') do
        to new_resource.filename
        action :delete
      end
    end
  end
end
