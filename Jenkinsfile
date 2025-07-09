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
                sh '''#!/bin/bash
                python3 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Application') {
            steps {
                sh '''#!/bin/bash
                source venv/bin/activate
                nohup python manage.py runserver 0.0.0.0:$APP_PORT > output.log 2>&1 &
                '''
            }
        }
    }
}
