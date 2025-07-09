pipeline {
    agent any

    environment {
        APP_PORT = "8000"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Umair1012/django-notes-app.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv venv
                    ./venv/bin/pip install --upgrade pip
                    ./venv/bin/pip install -r requirements.txt
                '''
            }
        }

       stage('Run Django') {
            steps {
                sh '''
                    tmux kill-session -t django || true  # Kill if already exists
                    tmux new-session -d -s django './venv/bin/python manage.py runserver 0.0.0.0:$APP_PORT'
                    sleep 5
                    tmux ls
                    ps aux | grep manage.py
                '''
    }
}

    }
}
