pipeline {
    agent any

    environment {
        APP_PORT = "8000"
        APP_HOST = "0.0.0.0"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Umair1012/django-notes-app.git'
            }
        }

        stage('Install Requirements') {
            steps {
                sh '''
                    python3 -m venv venv
                    venv/bin/pip install -r requirements.txt
                '''
            }
        }

        stage('Start Gunicorn') {
            steps {
                sh '''
                    pkill -f gunicorn || true
                    mkdir -p logs

                    venv/bin/gunicorn notesapp.wsgi:application \
                        --bind $APP_HOST:$APP_PORT \
                        --access-logfile logs/access.log \
                        --error-logfile logs/error.log &
                '''
            }
        }
    }
}
