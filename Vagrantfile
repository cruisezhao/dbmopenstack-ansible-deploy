VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use the same key for each machine
  #config.ssh.insert_key = false

  config.vm.define "controller" do |controller|
    controller.vm.box = "ubuntu/xenial64"
    config.vm.hostname = "controller"
    controller.vm.network "forwarded_port", guest: 80, host: 8080
    controller.vm.network "forwarded_port", guest: 22, host: 2202 
    controller.vm.network "private_network", ip: "10.0.1.11"
    controller.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 4
    end
  end
  config.vm.define "compute01" do |compute01|
    compute01.vm.box =   "ubuntu/xenial64"
    config.vm.hostname = "compute01"
    compute01.vm.network "forwarded_port", guest: 80, host: 8081
    compute01.vm.network "forwarded_port", guest: 22, host: 2200
    compute01.vm.network "private_network", ip: "10.0.1.31"
    compute01.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 8
    end

  end
end
