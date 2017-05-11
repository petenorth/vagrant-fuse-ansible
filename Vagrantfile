# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'socket'

hostname = Socket.gethostname
localmachineip = IPSocket.getaddress(Socket.gethostname)
puts %Q{ This machine has the IP '#{localmachineip} and host name '#{hostname}'}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

%w(vagrant-hostmanager).each do |plugin|
  # Will install dependent plugin
  unless Vagrant.has_plugin?(plugin)
    puts '*********************************'
    puts "Installing #{plugin} plugin"
    `vagrant plugin install #{plugin}`
  end
end

#Defaults
centos_box_name = 'centos/7'
NETWORK_BASE = '192.168.50'
INTEGRATION_START_SEGMENT = 20

FUSE_DISTRIBUTION_FOLDER='/home/pfry/projects/personal_NEW/fuse_distribution/'
MAVEN_REPO='/home/pfry/.m2/repository'
LOCAL_MAVEN_REPO='/opt/rh/fuse/local_maven_repo'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
#  config.hostmanager.include_offline = true
#  config.ssh.insert_key = false
 
  config.vm.provider "virtualbox" do |v|
     v.memory = 1024
     v.cpus = 1
  end

  
  config.vm.define :node1 do |node1|
    node1.vm.box = centos_box_name
    node1.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT}"
    node1.vm.hostname = "node1.example.com"
    node1.hostmanager.aliases = %w(node1)
    node1.vbguest.auto_update = false
  end

  config.vm.define :node2 do |node2|
    node2.vm.box = centos_box_name
    node2.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 1}"
    node2.vm.hostname = "node2.example.com"
    node2.hostmanager.aliases = %w(node2)
    node2.vbguest.auto_update = false
  end
 
  config.vm.define :node3 do |node3|
    node3.vm.box = centos_box_name
    node3.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 2}"
    node3.vm.hostname = "node3.example.com"
    node3.hostmanager.aliases = %w(node3)
    node3.vbguest.auto_update = false
  end

  config.vm.define :admin1 do |admin1|
    admin1.vm.box = centos_box_name
    admin1.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 3}"
    admin1.vm.hostname = "admin1.example.com"
    admin1.hostmanager.aliases = %w(admin1)
    admin1.vbguest.auto_update = false
    admin1.vm.synced_folder ".vagrant", "/home/vagrant/.hidden", type: "rsync"

    ansible_host_vars = {
      node1: {
        ansible_ssh_private_key_file: "/home/vagrant/.hidden/machines/node1/virtualbox/private_key",
#        ansible_ssh_host: "192.168.50.20"
      },
      node2: {
        ansible_ssh_private_key_file: "/home/vagrant/.hidden/machines/node2/virtualbox/private_key",
#        ansible_ssh_host: "192.168.50.21"
      },
      node3: {
        ansible_ssh_private_key_file: "/home/vagrant/.hidden/machines/node3/virtualbox/private_key",
#        ansible_ssh_host: "192.168.50.22"
      },
      adnin1: {
        ansible_connection: 'local'
      }
    }


    #admin1.vm.provision "shell", inline: "git clone https://github.com/petenorth/ansible-playbook-fuse.git"
    admin1.vm.synced_folder "#{FUSE_DISTRIBUTION_FOLDER}", "/opt/rh/fuse/distribution", create: true, type: "rsync"
    admin1.vm.provision "shell", inline: "cp /opt/rh/fuse/distribution/* /tmp"

    admin1.vm.provision :ansible_local do |ansible|
      ansible.verbose        = true
      ansible.install        = true
 #     #ansible.limit          = 'OSEv3:localhost'
      ansible.provisioning_path = '/vagrant'
      ansible.playbook       = '/vagrant/bootstrap.yaml'
      #ansible.groups = ansible_groups
      ansible.host_vars = ansible_host_vars
    end

    admin1.vm.provision :ansible_local do |ansible|
      ansible.verbose        = true
      ansible.install        = true
      ansible.limit          = 'node1'
      ansible.provisioning_path = '/home/vagrant/ansible-playbook-fuse'
      ansible.playbook       = '/home/vagrant/ansible-playbook-fuse/fuse-install.yaml'
      ansible.groups = {
        "fuse-vagrant" => ["node1"]
      }
      ansible.host_vars = ansible_host_vars
    end
  end

end
