# -*- mode: yaml -*-

{% for name,proj in salt['pillar.get']('projects', {}) %}
{{name}}:
  git.latest:
    - name: {{ proj.repo.name }}
    - target: {{ proj.repo.target }}
    - user: vagrant
{% endfor %}
