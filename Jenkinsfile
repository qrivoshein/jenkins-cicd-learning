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
        
        // ↓↓↓ ДОБАВЬ ЭТОТ STAGE ЗДЕСЬ ↓↓↓
        stage('Setup Frontend') {
            steps {
                echo 'Setting up frontend...'
                sh '''
                    # Копируем папку public в контейнер app
                    docker cp ./public demo-app:/app/
                    echo "Frontend files copied to container"
                    
                    # Проверяем что скопировалось
                    docker exec demo-app ls -la /app/public/
                '''
            }
        }
        // ↑↑↑ ДОБАВЬ ЭТОТ STAGE ЗДЕСЬ ↑↑↑
        
        stage('Test') {
            steps {
                echo 'Checking if app starts...'
                sh '''
                    docker run -d --name test-container test-app
                    sleep 3
                    docker ps | grep test-container && echo "Container is running!" || echo "Container failed to start"
                    docker logs test-container
                    docker stop test-container
                    docker rm test-container
                '''
            }
        }
        
        stage('Deploy Demo') {
            steps {
                echo 'Deploying to test environment...'
                sh '''
                    docker run -d --name demo-app -p 8081:3000 test-app
                    echo "Application deployed at: http://localhost:8081"
                    echo "Check running containers:"
                    docker ps
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed!'
            sh 'docker system prune -f'
        }
        success {
            echo '🎉 SUCCESS! CI/CD pipeline is working!'
            sh '''
                echo "Demo app is running at: http://localhost:8081"
                echo "To stop: docker stop demo-app"
            '''
        }
    }
}
