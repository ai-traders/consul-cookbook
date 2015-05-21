#
# Cookbook Name:: consul
# License:: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

consul_client 'consul' do
  binary_url node['consul']['remote_url']
  binary_version node['consul']['version']
  run_user node['consul']['service_user']
  run_group node['consul']['service_group']
end

consul_config File.join(node['consul']['config_dir'], 'default.json') do
  run_user node['consul']['service_user']
  run_group node['consul']['service_group']
end

consul_service node['consul']['service_name'] do
  run_user node['consul']['service_user']
  run_group node['consul']['service_group']
  action [:create, :start]
end
