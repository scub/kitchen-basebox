# vim: ft=yaml
{%- from "consul/map.jinja" import consul with context %}

{%- if consul.server.enabled %}

{%- if consul.server.snakeoil_cert %}
"consul.config: install snakeoil key":
  file.managed:
    - name: '/etc/ssl/private/consul.key'
    - source: salt://test/mockup/files/ssl/consul.key
    - user: root
    - group: consul
    - mode: 0640

"consul.config: install snakeoil certificate":
  file.managed:
    - name: '/etc/ssl/certs/consul.crt'
    - source: salt://test/mockup/files/ssl/consul.crt
    - user: root
    - group: consul
    - mode: 0640
{% endif %}

"consul.config: apply server configuration":
  file.serialize:
    - name: '/etc/consul.d/server.json'
    - dataset: {{ consul.server.config | yaml }}
    - formatter: json

"consul.config: apply server unit file":
  file.managed:
    - name: '/etc/systemd/system/consul-server.service'
    - source: salt://consul/files/consul-server.service

{% endif %}

{%- if consul.client.enabled %}
"consul.config: apply client configuration":
  test.succeed_without_changes
{% endif %}
