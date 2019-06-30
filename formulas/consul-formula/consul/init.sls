# vim: ft=yaml
#
{%- from "consul/map.jinja" import consul with context %}

{% if consul.enabled %}
include:
  - consul.install
  - consul.config
{% endif %}
