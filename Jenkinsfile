pipeline {
    agent any

    environment {
        APP_PORT = "8000"
        APP_HOST = "0.0.0.0"
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

        stage('Run with Gunicorn') {
            steps {
                sh '''
                    # Kill previous Gunicorn if running
                    pkill -f "gunicorn" || true

                    # Create logs folder
                    mkdir -p logs

                    # Run Gunicorn in background
                    ./venv/bin/gunicorn notesapp.wsgi:application \
                        --bind $APP_HOST:$APP_PORT \
                        --access-logfile logs/access.log \
                        --error-logfile logs/error.log

                    sleep 3
                    ps aux | grep gunicorn
                    tail -n 10 logs/access.log || true
                    tail -n 10 logs/error.log || true
                '''
            }
        }
    }
}
