# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Set image for the server
  config.vm.box = "generic-x64/ubuntu2204"

  # Define server for running flask
  config.vm.define "web" do |web|
    web.vm.hostname = "web.localdomain"
    web.vm.synced_folder(".code/app", "/home/vagrant/app")

    # Install packages needed for flask app
    web.vm.provision "shell", inline: <<-SHELL
      apt-get install -y python3-pip gunicorn
      cd /home/vagrant/app && /usr/bin/pip install -r requirements.txt
      /usr/bin/systemctl restart warpnet-sre-challenge.service
    SHELL
  end

  # Synchronize the hiera content, so we can make use of it
  config.vm.synced_folder(".deploy/vagrant/hiera", "/tmp/vagrant-puppet/hiera")

  # Install puppet, so we can use it for provisioning
  config.vm.provision "shell", inline: <<-SHELL
    /usr/bin/curl -s -o /tmp/puppet7-release-jammy.deb https://apt.puppet.com/puppet7-release-jammy.deb
    /usr/bin/dpkg -i /tmp/puppet7-release-jammy.deb
    /usr/bin/apt-get update
    /usr/bin/apt-get install -y puppet-agent
  SHELL

  # Provision the servers with use of puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = ".deploy/vagrant/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = ".deploy/vagrant/modules"
    puppet.hiera_config_path = ".deploy/vagrant/hiera.yaml"
  end
end
