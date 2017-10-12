# -*- mode: yaml -*-
include:
  - requirements
  - postgresql

{% for pj in salt['pillar.get']('projects') %}
{% for name, venv in pj.get('venvs', {}) %}
{{name}}:
  virtualenv.managed:
    - no_site_packages: True
    - user: vagrant
    - requirements: {{ venv.requirements }}
    - pip_upgrade: True
    - python: {{ venv.python }}
    - require:
      - pkgs: {{ venv.pkgs }}
{% endfor %}
{% endfor %}

{% for name, user in salt['pillar.get']('database:users', {}) %}
{{name}}-db_user:
  postgres_user.present:
    - name: {{ name }}
    - password: {{ user.password }}
    - user: postgres
    - require:
      - service: postgresql 
{% endfor %}

{% for name, db in salt['pillar.get']('database:databases', {]}) %}
{{name}}-db:
  postgres_database.present:
    - name: {{ name }}
    - encoding: {{ db.encoding }}
    - lc_ctype: {{ db.lc_ctype }}
    - lc_collate: {{ db.lc_collate }}
    - template: {{ db.template }}
    - owner: {{ db.owner }}
    - user: postgres
    - require:
      - postgres_user: {{ db.owner }}-db_user
{% endfor %}

/home/vagrant/quizrt/.env:
  file.managed:
    - source: salt://files/env
    - template: jinja
    - user: vagrant
    - group: vagrant
    - mode: 0644
