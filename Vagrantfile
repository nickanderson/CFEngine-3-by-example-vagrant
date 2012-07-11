# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'cfengine_provisioner.rb'

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # Use this basebox image
  config.vm.box = "centos_6_x86_64_minimal_4.1.12"
  # If the basebox image is not yet cached on the local system source it from here
  config.vm.box_url = "https://dl.dropbox.com/u/5861161/vagrant/CentOS-6.0-x86_64-netboot-4.1.12.box"

  # CFEngine really doens't require much in the way of resources
  config.vm.customize ["modifyvm", :id, "--memory", 256]

  # Use this for debugging or getting a better visual picture of whats
  # happening. There may be some bugs related to gui mode that may or
  # may not have anything to do with the CFEngine provider.
  config.vm.boot_mode = :gui


  # Policy Hub Definition
  config.vm.define :cfhub do |hub_config|
    # Hostname to set on the node
    hub_config.vm.host_name="cfhub"

    # Hostonly network interface, used for internode communication
    hub_config.vm.network :hostonly, "10.1.1.10"

    # CFEngine Provisioner Settings
    hub_config.vm.provision CFEngineProvisioner do |cf3|
      # Install CFEngine if it is not already installed
      # cf3.install_cfengine = true
        
      # This node is a policy hub
      # cf3.am_policy_hub = true

      # Bootstrap CFEngine after installing 
      # cf3.bootstrap = true

      # Address of the policy server to use for bootstrapping.
      # This should be the same ip as the hubs hostonly interface
      cf3.policy_server = "10.1.1.10"

      # Seed the /var/cfengine directory with the contents of this targz
      # Your host system will need to be running a webserver and have this file
      # available for downloading.
      cf3.cfengine_tarfile_url = 'http://localhost:8000/seed.tar.gz'
    end
  end

  # Remote Client Definition
  config.vm.define :cfclient do |client_config|
    # Hostname to set on the node
    client_config.vm.host_name="cfclient"

    # Hostonly network interface, used for internode communication
    client_config.vm.network :hostonly, "10.1.1.11"

    # CFEngine Provisioner Settings
    client_config.vm.provision CFEngineProvisioner do |cf3|
      # Install CFEngine if it is not already installed
      # cf3.install_cfengine = true
 
      # Bootstrap CFEngine after installing 
      # cf3.bootstrap = true

      # This node is a policy hub
      # This does not change much for what happens when the provisioner
      # runs. Currently the only difference is some informational output
      # and whether or not to kick off a policy run after bootstrap.
      # Policy hubs may need this to do some prepartion for clients to
      # be able to successfully bootstrap.
      cf3.am_policy_hub = false

      # Address of the policy server to use for bootstrapping.
      # This should be the same ip as the hubs hostonly interface
      cf3.policy_server = "10.1.1.10" 
    end
  end

end
