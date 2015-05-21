Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.box = ENV.fetch('VAGRANT_VM_BOX', 'opscode-ubuntu-12.04')
  config.vm.box_url = ENV.fetch('VAGRANT_VM_BOX_URL', 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box')

  config.vm.define :bootstrap, primary: true do |guest|
    guest.vm.network :private_network, ip: '172.16.38.10'
    guest.vm.provision :chef_zero do |chef|
      chef.nodes_path = File.expand_path('../.vagrant.d/chef/nodes', __FILE__)
      chef.run_list = ['recipe[consul::default]', 'recipe[consul::ui]']
    end
  end
end
