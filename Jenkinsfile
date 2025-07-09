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
                    nohup ./venv/bin/python manage.py runserver 0.0.0.0:$APP_PORT > /tmp/django.log 2>&1 &
                    sleep 5
                    ps aux | grep manage.py
                    tail -n 10 /tmp/django.log
                '''
            }
        }
    }
}
