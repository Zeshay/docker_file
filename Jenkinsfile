pipeline {
    agent any

    environment {
        APP_PORT = "8000"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Umair1012/django-notes-app.git'
            }
        }

        stage('Setup & Install') {
            steps {
                sh '''
                python3 -m venv venv
                . venv/bin/activate
                pip install -r requirements.txt
                '''
            }
        }

        stage('Apply Migrations') {
            steps {
                sh '''
                . venv/bin/activate
                python manage.py makemigrations
                python manage.py migrate
                '''
            }
        }

        stage('Start Django App') {
            steps {
                sh '''
                . venv/bin/activate
                nohup python manage.py runserver 0.0.0.0:$APP_PORT > django.log 2>&1 &
                sleep 5
                tail -n 20 django.log
                '''
            }
        }
    }
}
