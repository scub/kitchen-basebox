{%- from "consul/map.jinja" import consul with context %}


{%- if consul.server.enabled %}
'consul.service: Add server unit file':
  file.managed:
    - name: '/etc/systemd/system/consul-server.service'
    - source: salt://consul/files/consul-server.service
{% endif %}
