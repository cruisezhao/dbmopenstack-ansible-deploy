VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use the same key for each machine
  #config.ssh.insert_key = false

  config.vm.define "controller" do |controller|
    controller.vm.box = "ubuntu/xenial64"
    config.vm.hostname = "controller"
    controller.vm.network "forwarded_port", guest: 80, host: 8081
    controller.vm.network "forwarded_port", guest: 22, host: 2201 
    controller.vm.network "private_network", ip: "10.0.1.11"
    controller.vm.network "private_network", ip: "192.168.100.11"
    controller.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 4
    end
  end
  config.vm.define "network" do |network|
    network.vm.box =   "ubuntu/xenial64"
    config.vm.hostname = "network"
    network.vm.network "forwarded_port", guest: 80, host: 8082
    network.vm.network "forwarded_port", guest: 22, host: 2202
    network.vm.network "private_network", ip: "10.0.1.21"
    network.vm.network "private_network", ip: "192.168.100.21"
    network.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 8
    end
  end
  config.vm.define "compute01" do |compute01|
    compute01.vm.box =   "ubuntu/xenial64"
    config.vm.hostname = "compute01"
    compute01.vm.network "forwarded_port", guest: 80, host: 8083
    compute01.vm.network "forwarded_port", guest: 22, host: 2203
    compute01.vm.network "private_network", ip: "10.0.1.31"
    compute01.vm.network "private_network", ip: "192.168.100.31"
    compute01.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 8
    end
  end
end
