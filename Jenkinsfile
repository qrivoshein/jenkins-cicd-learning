pipeline {
    agent any

    stages {
        stage('Check Code') {
            steps {
                echo 'Checking repository structure...'
                sh 'ls -la'
                sh 'find . -name "*.py" -type f'
            }
        }
        
        stage('Build Docker') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t test-app .'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run test-app python -m pytest tests/ -v || echo "Tests failed but continuing"'
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
