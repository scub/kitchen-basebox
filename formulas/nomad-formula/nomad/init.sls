# -*- coding: utf-8 -*-
# vim: ft=sls

"test.mockup.init: install tooling":
  pkg.installed:
    - pkgs:
      - git
      - tmux
      - vim-nox
      - nmap
      - netcat-openbsd
      - ccze
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg-agent
      - software-properties-common


"test.mockup.init: shut off RPCbind if its found alive":
  service.disabled:
    - name: "rpcbind"

# Needs jinja mapping / pillar controls
"test.mockup.init: Download Nomad 0.9.3":
  file.managed:
    - name: "/tmp/nomad-0.9.3.zip"
    - source: https://releases.hashicorp.com/nomad/0.9.3/nomad_0.9.3_linux_amd64.zip
    - source_hash: 'a7660832b4e389e555f5316cbfccca2a'
    - onlyif: ! -e /tmp/nomad-0.9.3.zip

"test.mockup.init: Install Nomad from archive (.zip)":
  archive.extracted:
    - name: '/usr/local/bin'
    - source: "/tmp/nomad-0.9.3.zip"
    # Scary
    - enforce_toplevel: False
    - onlyif: ! -e /usr/local/bin/nomad

### Install Docker
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
#       9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"
#"apt-get install docker-ce docker-ce-cli containerd.io"


## Startup Docker registry
# docker run -d -p 5000:5000 --restart=always --name registry registry:2


# Custom storage
# $ docker run -d \
#  -p 5000:5000 \
#  --restart=always \
#  --name registry \
#  -v /mnt/registry:/var/lib/registry \
#  registry:2
#

## Copy an image from Docker Hub to your registry
#
# $ docker pull debian:9
# uwsgi.ini
# [uwsgi]
# module = main
# callable = app
# master = true


# Clients
# $ docker pull ubuntu:16.04
# $ docker tag ubuntu:16.04 myregistrydomain.com/my-ubuntu
# $ docker push myregistrydomain.com/my-ubuntu
# $ docker pull myregistrydomain.com/my-ubuntu
