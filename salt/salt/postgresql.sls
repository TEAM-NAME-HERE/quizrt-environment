# -*- mode: yaml -*-

{% set db = salt['pillar.get']('database', {}) %}

{{db.name}}:
  pkg.installed:
    - pkgs: {{db.pkgs}}
  service.running:
    - enabled: True
{% if db.get('watch', False) %}
    - watch: {{db.watch}}

{% for name, file in db.get('files', {}) }
{{name}}:
  file.managed:
    - source: {{ file.source }}
    - user: {{ file.user }}
    - group: {{ file.group }}
    - mode: {{ file.mode }}
    - template: jinja
    - require:
      - pkg: {{db.name}}
{% endfor %}
