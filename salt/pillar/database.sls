database:
  name: postgresql
  pkgs: ['postgresql-9.5', 'postgresql-contrib-9.5']
  watch: 
    - file: /etc/postgresql/9.5/main/pg_hba.conf
  files:
    /etc/postgresql/9.5/main/pg_hba.conf:
      source: salt://files/pg_hba.conf
      user: postgres
      group: postgres
      mode: 0644
  users:
    django:
      password: django
  databases:
    quizrt:
      owner: django
      encoding: UTF8
      lc_ctype: en_US.UTF8
      lc_collate: en_US.UTF8
      template: template0

django:
  db:
    engine: django.db.backends.postgresql_psycopg2
    name: quizrt
    user: django
    password: django 
    host: localhost
    port: 5432
    secret_key: secret_key
