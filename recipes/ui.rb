#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014, 2015 Bloomberg Finance L.P.
#

consul_client 'consul_ui' do
  binary_url ''
  binary_checksum ''
  binary_version ''
  run_user node['consul']['service_user']
  run_group node['consul']['service_group']
end
