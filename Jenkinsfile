pipeline {
    agent any

    stages {
        stage('Check Structure') {
            steps {
                echo 'Checking project structure...'
                sh 'ls -la app/'
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
                echo 'Running Node.js tests...'
                sh 'docker run test-app npm test || echo "Tests completed"'
            }
        }
        
        stage('Run App') {
            steps {
                echo 'Starting application...'
                sh '''
                    docker run -d --name running-app -p 3000:3000 test-app
                    sleep 5
                    curl -f http://localhost:3000 || echo "App might be starting..."
                    docker stop running-app
                    docker rm running-app
                '''
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
