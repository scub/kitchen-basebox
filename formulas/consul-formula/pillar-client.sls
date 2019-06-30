
# vim: ft=yaml

consul:
  enabled: True
  client:
    enabled: True
  server:
    enabled: True
    snakeoil_cert: True
    config:
      server: true
      datacenter: 'atlanta'
      node_name: 'consul1'
      log_level: 'INFO'
      #key_file: '/etc/ssl/private/consul.key'
      #cert_file: '/etc/ssl/certs/consul.crt'
      addresses:
        http: '0.0.0.0'
      ports:
        http: '8500'
      telemetry:
        statsite_address: '127.0.0.1:2180'
