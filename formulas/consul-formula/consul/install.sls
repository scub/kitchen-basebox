{%- from "consul/map.jinja" import consul with context %}

'consul.install: Pull Consul binaries':
  file.managed:
    - name: '/tmp/consul.zip'
    - source: 'https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip'
    - source_hash: '40b18456326e35173c7c69bb5ec03bb8'
    - onlyif: test ! -e /tmp/consul.zip

'consul.install: extract consul archive':
  archive.extracted:
    - name: '/usr/local/bin'
    - source: '/tmp/consul.zip'
    - enforce_toplevel: False
    - onlyif: test ! -e /usr/local/bin/consul

'consul.install: create consul service user':
  user.present:
    - name: 'consul'
    - fullname: "Consul service"
    - shell: /bin/bash
    - home: "/opt/consul"

'consul.install: create config hier':
  file.directory:
    - name: '/etc/consul.d'
    - makedirs: True
    - user: 'consul'

'consul.install: create data hier':
  file.directory:
    - name: '/opt/consul/data'
    - user: 'consul'
    - group: 'consul'


