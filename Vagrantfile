# -*- mode: ruby -*-
# vim: ft=ruby

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    os = "bento/ubuntu-16.04"
    net_ip = "192.168.50"

    config.vm.define :dev, primary :true do |dev_config|
        dev.config.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = 1
            vb.name = "dev"
        end
        dev_config.vm.box = "#{os}"
        dev_config.vm.hostname = "dev.local"
        dev_config.vm.network "private_network", ip: "#{net_ip}.10"
        dev_config.vm.synced_folder "api", "/home/vagrant/quizrt"  
        dev_config.vm.synced_folder "frontend", "/home/vagrant/quizrt-frontend"
        dev_config.vm.synced_folder "salt/salt", "/srv/salt/"
        dev_config.vm.synced_folder "salt/pillar", "/srv/pillar"

        dev_config.vm.provision :salt do |salt|
            salt.masterless = true
            salt.minion_config = "salt/minion"
            salt.run_highstate = true
            salt.colorize = true
        end
    end
end
