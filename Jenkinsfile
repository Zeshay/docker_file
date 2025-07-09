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
                # Install python3-venv if needed (skip sudo here; preinstall manually on Jenkins host)
                python3 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Run Application') {
            steps {
                sh '''
                source venv/bin/activate
                nohup python manage.py runserver 0.0.0.0:$APP_PORT > output.log 2>&1 &
                '''
            }
        }
    }
}
