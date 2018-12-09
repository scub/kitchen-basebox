# -*- coding: utf-8 -*-
# vim: ft=sls

"test.mockup.init: Example shim that does nothing":
  test.succeed_without_changes

"test.mockup.init: install tooling":
  pkg.installed:
    - pkgs:
      - git
      - vim-nox
      - nmap
      - netcat-openbsd
      - ccze

"test.mockup.init: shut off RPCbind if its found alive":
  service.disabled:
    - name: "rpcbind"
