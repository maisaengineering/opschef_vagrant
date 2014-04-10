# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
config.vm.box = "ubuntu_precise"

# set auto_update to false, if you do NOT want to check the correct
# additions version when booting this machine
config.vbguest.auto_update = false
# do NOT download the iso file from a webserver
config.vbguest.no_remote = true

# config.berkshelf.enabled = true
config.vm.provider :virtualbox do |vb|
  # Don't boot with headless mode
  vb.gui = false

  # Use VBoxManage to customize the VM. For example to change memory:
  vb.customize ["modifyvm", :id, "--memory", "1024"]
end

 # config.chef.log_level = :debug
 host_cache_path = File.expand_path("../.cache", __FILE__)
 guest_cache_path = "/tmp/vagrant-cache"
 VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('nodes', 'chef.json').read)

 # chef servers
 config.vm.define "chef_server" do |chef_server|
    chef_server.vm.box = "ubuntu_precise"
    
    chef_server.vm.network "private_network", ip: "192.168.50.101"
     #   auto_config: false
    # chef_server.vm.network :private_network, :ip => '127.0.0.9', :auto_network => true

    config.vm.provision :shell, :inline => "sudo apt-get update"
#     config.vm.provision :shell, :inline => 'sudo apt-get install ruby1.9.2 ruby1.9.2-dev \
# rubygems1.9.2 irb1.9.2 ri1.9.2 rdoc1.9.2 \
# build-essential libopenssl-ruby1.9.2 libssl-dev zlib1g-dev'
    # config.vm.provision :shell, :inline => "curl -sSL https://get.rvm.io | sudo bash -s stable"
    # config.vm.provision :shell, :inline => "rvm install 1.9.2"
    # config.vm.provision :shell, :inline => "sudosource /usr/local/rvm/scripts/rvm"
    config.vm.provision :shell, :inline => "sudo gem install chef --version 11.10.4 --no-rdoc --no-ri --conservative"
    chef_server.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
      chef.roles_path = "roles"
      chef.data_bags_path = "data_bags"
      chef.provisioning_path = guest_cache_path

      # You may also specify custom JSON attributes:
      chef.run_list = VAGRANT_JSON.delete('run_list') if VAGRANT_JSON['run_list']
      chef.json = VAGRANT_JSON
      Dir.glob(Pathname(__FILE__).dirname.join('roles', 'chef.json')).each do |role|
        chef.add_role(Pathname.new(role).basename(".*").to_s)
      end
    end
  end

  # chef nodes (not provisioned via vagrant plugin)
  config.vm.define "app" do |chef_client|
     chef_client.vm.hostname="app"
     chef_client.vm.box = "ubuntu_precise"
     chef_client.vm.network "private_network", ip: "192.168.50.201"
   end

   config.vm.define "mongomaster" do |chef_client|
      chef_client.vm.hostname="mongomaster"
      chef_client.vm.box = "ubuntu_precise"
      chef_client.vm.network "private_network", ip: "192.168.50.199"
   end
end
