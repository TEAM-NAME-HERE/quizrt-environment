include:
  - requirements
  - postgresql

{% for pjname, pj in salt['pillar.get']('projects', {}).iteritems() %}
{% for name, venv in pj.get('venvs', {}).iteritems() %}
{{name}}-pkgs:
  pkg.installed:
    - pkgs: {{ venv.pkgs }}

{{name}}/.venv:
  virtualenv.managed:
    - system_site_packages: False
    - user: vagrant
    - requirements: {{ venv.requirements }}
    - pip_upgrade: True
    - python: {{ venv.python }}
    - require:
      - pkg: {{ name }}-pkgs
{% endfor %}
{% endfor %}

{% for name, user in salt['pillar.get']('database:users', {}).iteritems() %}
{{name}}-db_user:
  postgres_user.present:
    - name: {{ name }}
    - password: {{ user.password }}
    - user: postgres
    {% for perm, val in user.get('permissions', {}).iteritems() %}
    - {{perm}}: {{val}}
    {% endfor %}
    - require:
      - service: postgresql 
{% endfor %}

{% for name, db in salt['pillar.get']('database:databases', {}).iteritems() %}
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
