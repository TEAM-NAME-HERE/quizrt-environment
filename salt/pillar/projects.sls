# -*- mode: yaml -*-

projects:
  quizrt:
    repo:
       name: https://github.com/TEAM-NAME-HERE/quizrt.git
       target: /home/vagrant/quizrt
    venvs:
      /home/vagrant/quizrt:
        requirements: /home/vagrant/quizrt/requirements/local.txt
        python: python3
        pkgs: ['libpq-dev', 'python-virtualenv']

  quizrt-frontend:
    repo:
      name: https://github.com/TEAM-NAME-HERE/quizrt-frontend.git
      target: /home/vagrant/quizrt-frontend
