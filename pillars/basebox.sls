# -*- coding: utf-8 -*-
# vim: ft=sls
#
# Default state
#

firewall:
  install: True
  enabled: True
  strict:  True
  services:
    ssh:
      protos:
        - tcp

sshd_config:
  Port: 22
  PermitRootLogin: 'without-password'
  Subsystem: 'sftp /usr/lib/openssh-sftp-server'
