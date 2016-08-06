
# Install missing pluggins
required_plugins = %w( vagrant-hostmanager vagrant-vbguest )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
        exec "vagrant #{ARGV.join(' ')}"
    else
        abort "Installation of one or more plugins has failed. Aborting."
    end
end

# Configuration
Vagrant.configure("2") do |config|

    #VM setup
    config.vm.box = 'ubuntu/trusty64'
    #config.vm.hostname = "triip.dev"

    #hostmanager
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = %w(symfony2.dev symfony3.dev)

    config.ssh.forward_agent = true

    # Configure the network interfaces
    config.vm.network :private_network, ip:    "192.168.10.10"
    config.vm.network :forwarded_port,  guest: 3306,  host: 33060

    # Configure VirtualBox environment
    config.vm.provider :virtualbox do |v|
        v.name = "learning-" + (0...8).map { (65 + rand(26)).chr }.join
        v.customize [ "modifyvm", :id, "--memory", 2048 ]
    end

    # Configure synced folders
    config.vm.synced_folder "../symfony2", "/var/www/symfony2", id: "vagrant-base",
        owner: "vagrant",
        group: "www-data",
        mount_options: ["dmode=777,fmode=777"],
        create: true

    config.vm.synced_folder "../symfony3", "/var/www/symfony3", id: "vagrant-symfony3",
        owner: "vagrant",
        group: "www-data",
        mount_options: ["dmode=777,fmode=777"],
        create: true

    # Provision the box
    config.vm.provision :ansible do |ansible|
        ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
        #ansible.verbose = "vvv"
        ansible.playbook = "ansible/site.yml"
    end
end
