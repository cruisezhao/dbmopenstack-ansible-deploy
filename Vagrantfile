VAGRANTFILE_API_VERSION = "2"

disk_ceph01 = '.ceph01_secondDisk.vdi'
disk_ceph02 = '.ceph02_secondDisk.vdi'
disk_ceph03 = '.ceph03_secondDisk.vdi'
disk_ceph04 = '.ceph04_secondDisk.vdi'

$script1 = <<SCRIPT
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
SCRIPT

$script2 = <<SCRIPT
echo "auto enp0s8
iface enp0s8 inet manual" >> /etc/network/interfaces
ifconfig enp0s8 down
ifconfig enp0s8 up
SCRIPT

$script3 = <<SCRIPT
echo "10.0.0.11 controller
10.0.0.21 network
10.0.0.31 compute" >> /etc/hosts
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use the same key for each machine
  config.ssh.insert_key = false
  config.vm.provision "file", source: "/root/.ssh/id_rsa.pub", destination: "/tmp/id_rsa.pub"
  config.vm.provision "shell", inline: $script1
  config.vm.provision "shell", inline: $script3
  config.vm.boot_timeout = 1000
  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.define "controller" do |controller|
    controller.vm.box = "bento/ubuntu-16.04"
    controller.vm.hostname = "controller"
    controller.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true	  
    controller.vm.network "private_network", ip: "10.0.0.11"
    controller.vm.network "private_network", ip: "192.168.100.11"
    controller.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 4
    end
  end

  config.vm.define "network" do |network|
    network.vm.box = "bento/ubuntu-16.04"
    network.vm.hostname = "network"
	network.vm.boot_timeout = 600
    network.vm.provision "shell", inline: $script2
    network.vm.network "private_network", type: "dhcp", auto_config: false	
    network.vm.network "private_network", ip: "10.0.0.21"
    network.vm.network "private_network", ip: "192.168.100.21"	
    network.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 4
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  config.vm.define "compute" do |compute|
    compute.vm.box = "bento/ubuntu-16.04"
    compute.vm.hostname = "compute"	
	compute.vm.boot_timeout = 600
    compute.vm.provision "shell", inline: $script2
    compute.vm.network "private_network", type: "dhcp", auto_config: false	
    compute.vm.network "private_network", ip: "10.0.0.31"
    compute.vm.network "private_network", ip: "192.168.100.31"	
    compute.vm.provider "virtualbox" do |v|
      v.memory = 8192
      v.cpus = 4
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
    end
  end

  config.vm.define "ceph01" do |ceph01|
    ceph01.vm.box = "bento/ubuntu-16.04"
    ceph01.vm.hostname = "ceph01"
    ceph01.vm.boot_timeout = 600	
    ceph01.vm.network "private_network", ip: "192.168.100.110"
    ceph01.vm.network "private_network", ip: "192.168.200.110"		
    ceph01.vm.provider "virtualbox" do |v|
      unless File.exist?(disk_ceph01)
        v.customize ['createhd', '--filename', disk_ceph01, '--variant', 'Standard', '--size', 20 * 1024]
      end
      v.memory = 8192
      v.cpus = 4
      v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_ceph01]
    end
  end

  config.vm.define "ceph02" do |ceph02|
    ceph02.vm.box = "bento/ubuntu-16.04"
    ceph02.vm.hostname = "ceph02"
    ceph02.vm.boot_timeout = 600	
    ceph02.vm.network "private_network", ip: "192.168.100.111"
    ceph02.vm.network "private_network", ip: "192.168.200.111"	
    ceph02.vm.provider "virtualbox" do |v|
      unless File.exist?(disk_ceph02)
        v.customize ['createhd', '--filename', disk_ceph02, '--variant', 'Standard', '--size', 20 * 1024]
      end
      v.memory = 8192
      v.cpus = 4
      v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_ceph02]
    end
  end

  config.vm.define "ceph03" do |ceph03|
    ceph03.vm.box = "bento/ubuntu-16.04"
    ceph03.vm.hostname = "ceph03"
    ceph03.vm.boot_timeout = 600	
    ceph03.vm.network "private_network", ip: "192.168.100.121"
    ceph03.vm.network "private_network", ip: "192.168.200.121"	
    ceph03.vm.provider "virtualbox" do |v|
      unless File.exist?(disk_ceph03)
        v.customize ['createhd', '--filename', disk_ceph03, '--variant', 'Standard', '--size', 20 * 1024]
      end
      v.memory = 8192
      v.cpus = 4
      v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_ceph03]
    end
  end

  config.vm.define "ceph04" do |ceph04|
    ceph04.vm.box = "bento/ubuntu-16.04"
    ceph04.vm.hostname = "ceph04"
    ceph04.vm.boot_timeout = 600	
    ceph04.vm.network "private_network", ip: "192.168.100.131"
    ceph04.vm.network "private_network", ip: "192.168.200.131"	
    ceph04.vm.provider "virtualbox" do |v|
      unless File.exist?(disk_ceph04)
        v.customize ['createhd', '--filename', disk_ceph04, '--variant', 'Standard', '--size', 20 * 1024]
      end
      v.memory = 8192
      v.cpus = 4
      v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_ceph04]
    end
  end

end
