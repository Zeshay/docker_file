pipeline {
    agent any

    stages {
        stage('Clone the Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Umair1012/django-notes-app.git'
            }
        }

        stage('Create Virtual Environment and Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv django
                    . django/bin/activate
                    ./django/bin/pip install --upgrade pip
                    ./django/bin/pip install -r requirements.txt
                '''
            }
        }

        stage('Run Django App') {
            steps {
                sh '''
                    ./django/bin/python manage.py makemigrations
                    ./django/bin/python manage.py migrate
                    ./django/bin/gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000
                '''
            }
        }
    }
}

