# -*- mode: yaml -*-

packages:
  pkg.installed:
    - pkgs:
      - git
      - python3
      - python3-venv
      - libpq-dev

install nvm:
  cmd.run:
    - name: >-
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
    - runas: vagrant
