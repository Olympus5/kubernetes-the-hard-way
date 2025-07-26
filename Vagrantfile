SERVICES = {
  'jumpbox' => {
    ip: '192.168.56.10',
  },
  'server' => {
    ip: '192.168.56.11',
  },
  'node-0' => {
    ip: '192.168.56.12'
  },
  'node-1' => {
    ip: '192.168.56.13'
  }
}

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.box_version = "12.20250126.1"

  config.vm.define "jumpbox" do |jumpbox|
    jumpbox.vm.hostname = "jumpbox"
    jumpbox.vm.network "private_network", ip: SERVICES['jumpbox'][:ip]

    jumpbox.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end

    jumpbox.vm.provision "shell", name: "setup-k8s-components", path: "setup-k8s-components.sh"
  end

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: SERVICES['server'][:ip]

    server.vm.provider "virtualbox" do |vb|
      vb.memory = 2 * 1024
      vb.cpus = 1
    end
  end

  config.vm.define "node-0" do |node_0|
    node_0.vm.hostname = "node-0"
    node_0.vm.network "private_network", ip: SERVICES['node-0'][:ip]

    node_0.vm.provider "virtualbox" do |vb|
      vb.memory = 2 * 1024
      vb.cpus = 1
    end
  end

  config.vm.define "node-1" do |node_1|
    node_1.vm.hostname = "node-1"
    node_1.vm.network "private_network", ip: SERVICES['node-1'][:ip]

    node_1.vm.provider "virtualbox" do |vb|
      vb.memory = 2 * 1024
      vb.cpus = 1
    end
  end
end
