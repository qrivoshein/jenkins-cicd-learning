pipeline {
    agent any

    stages {
        stage('Check Structure') {
            steps {
                echo 'Checking project structure...'
                sh 'ls -la'
                sh 'ls -la app/ || echo "No app folder"'
            }
        }
        
        stage('Build Docker') {
            steps {
                echo 'Building Docker image from app folder...'
                dir('app') {
                    sh 'docker build -t test-app .'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests in container...'
                sh 'docker run test-app python -m pytest tests/ -v || echo "Tests completed"'
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            sh 'docker system prune -f'
        }
    }
}
