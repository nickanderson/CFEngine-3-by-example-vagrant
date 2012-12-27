# -*- mode: ruby -*-
# vi: set ft=ruby :

require './cfengine_provisioner.rb'

CFENGINE_DIST="community"

# NOTE: Change this to 3.4.1 if you want to use Ubuntu below
CFENGINE_VERSION="3.4.1-1" 
CFENGINE_INSTALL_SCRIPT="install_cfengine.sh"
HUBIP="10.1.1.10"

Vagrant::Config.run do |config|

  # Valid Boot Modes: *headless|gui
  #config.vm.boot_mode = "gui"

  # Ubuntu 12.04 - 32 bit
  # Download the correct CFEngine version with:
  #  cd packages && curl -O -J -L https://cfengine.com/inside/binarydownload/download/items/990
  #config.vm.box = "precise32"
  #config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  # Ubuntu 12.04 - 64 bit
  # Download the correct CFEngine version with:
  #  cd packages && curl -O -J -L https://cfengine.com/inside/binarydownload/download/items/976
  #config.vm.box = "precise64"
  #config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  # Generic Centos 6 minimal install with guest additions
  config.vm.box = "centos-6x_i386-minimal-4.1.22"
  config.vm.box_url = "https://dl.dropbox.com/u/5861161/vagrant/centos-6x_i386-minimal-4.1.22.box"

  #### Define VMs ####

  # First create the hub
  config.vm.define :cfhub do |hub_config|

    # Host config
    hub_config.vm.host_name = "cfhub"
    hub_config.vm.network :hostonly, "#{HUBIP}"
    hub_config.vm.forward_port 80, 8080

    # Install CFEngine
    hub_config.vm.provision :shell do |shell|
      shell.path = "#{CFENGINE_INSTALL_SCRIPT}"
      shell.args = "#{CFENGINE_DIST} hub #{CFENGINE_VERSION}"
    end

    # Run the CFEngine provisioner
    hub_config.vm.provision CFEngineProvisioner do |cf3|
      cf3.mode = :bootstrap
      cf3.policy_server = "#{HUBIP}"
      cf3.am_policy_hub = true
      cf3.tarfile_path = "seed.tar.gz"
    end
  end

  # Now create a client
  config.vm.define :cfclient1 do |hub_config|

    # Host config
    hub_config.vm.host_name = "cfclient1"
    hub_config.vm.network :hostonly, "10.1.1.11"

     # Install CFEngine
     hub_config.vm.provision :shell do |shell|
       shell.path = "#{CFENGINE_INSTALL_SCRIPT}"
       shell.args = "#{CFENGINE_DIST}"
     end

     # Run the CFEngine provisioner
     hub_config.vm.provision CFEngineProvisioner do |cf3|
       cf3.mode = :bootstrap
       cf3.am_policy_hub = false
       cf3.policy_server = "#{HUBIP}"
     end
  end
end
