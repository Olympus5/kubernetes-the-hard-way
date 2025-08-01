#!/bin/bash

apt-get update
apt-get install -y wget curl vim openssl git

if [ ! -d "/home/vagrant/kubernetes-the-hard-way/.git" ]; then
    cd /home/vagrant
    rm -rf kubernetes-the-hard-way
    git clone --depth 1 https://github.com/kelseyhightower/kubernetes-the-hard-way.git
fi

cd kubernetes-the-hard-way

arch=$(dpkg --print-architecture)

if [ ! -d "/home/vagrant/kubernetes-the-hard-way/downloads" ]; then
    wget -q --show-progress --https-only --timestamping -P downloads -i downloads-${arch}.txt

    mkdir -p downloads/{clients,cni-plugins,controller,worker}

    tar -xvf downloads/crictl-v1.32.0-linux-${arch}.tar.gz -C downloads/worker/
    tar -xvf downloads/containerd-2.1.0-beta.0-linux-${arch}.tar.gz --strip-components=1 -C downloads/worker/
    tar -xvf downloads/cni-plugins-linux-${arch}-v1.6.2.tgz -C downloads/cni-plugins/
    tar -xvf downloads/etcd-v3.6.0-rc.3-linux-${arch}.tar.gz -C downloads/ --strip-components=1 etcd-v3.6.0-rc.3-linux-${arch}/etcdctl etcd-v3.6.0-rc.3-linux-${arch}/etcd
    mv downloads/{etcdctl,kubectl} downloads/clients/
    mv downloads/{etcd,kube-apiserver,kube-controller-manager,kube-scheduler} downloads/controller/
    mv downloads/{kubelet,kube-proxy} downloads/worker/
    mv downloads/runc.${arch} downloads/worker/runc

    rm -rf downloads/*gz

    chmod +x downloads/{clients,cni-plugins,controller,worker}/*
fi

if [ ! -d "/usr/local/bin/kubectl" ]; then
    cp downloads/clients/kubectl /usr/local/bin/
fi

kubectl version --client

mv /home/vagrant/machines.txt /home/vagrant/kubernetes-the-hard-way