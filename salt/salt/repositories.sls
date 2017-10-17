# -*- mode: yaml -*-

{% for name,proj in salt['pillar.get']('projects', {}).iteritems() %}
{{name}}:
  git.latest:
    - name: {{ proj.repo.name }}
    - target: {{ proj.repo.target }}
    - user: vagrant
{% endfor %}
