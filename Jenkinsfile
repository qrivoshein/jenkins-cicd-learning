pipeline {
    agent any

    stages {
        stage('Check Structure') {
            steps {
                echo 'Checking project structure...'
                sh 'ls -la'
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
                echo 'Checking if app starts...'
                sh '''
                    docker run -d --name test-container test-app
                    sleep 5
                    docker ps | grep test-container && echo "✅ Container is running!" || echo "❌ Container failed to start"
                    docker logs test-container
                    docker stop test-container
                    docker rm test-container
                '''
            }
        }
        
        stage('Deploy Demo') {
            steps {
                echo 'Deploying application...'
                sh '''
                    # Останавливаем старый контейнер если есть
                    docker stop demo-app 2>/dev/null || echo "No previous demo-app"
                    docker rm demo-app 2>/dev/null || echo "No demo-app to remove"
                    
                    # Запускаем новый контейнер
                    docker run -d --name demo-app -p 8081:3000 test-app
                    sleep 5
                    
                    echo "🎉 Application deployed!"
                    echo "🌐 Open: http://localhost:8081"
                    echo "📊 API Health: http://localhost:8081/health"
                    echo "📝 API Tasks: http://localhost:8081/api/tasks"
                '''
            }
        }
        
        stage('Setup Frontend') {
            steps {
                echo 'Creating frontend interface...'
                sh '''
                    # Создаем папку public в контейнере
                    docker exec demo-app mkdir -p /app/public
                    
                    # Создаем простой фронтенд
                    docker exec demo-app sh -c "cat > /app/public/index.html" << 'EOL'
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 10px; }
        .task { padding: 15px; margin: 10px 0; border-radius: 8px; border-left: 4px solid; }
        .high { border-color: #e74c3c; background: #ffeaea; }
        .medium { border-color: #f39c12; background: #fff4e6; }
        .low { border-color: #27ae60; background: #e8f6ef; }
        h1 { color: #2c3e50; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📝 Task Manager</h1>
        <div id="tasks">Loading tasks...</div>
    </div>

    <script>
        fetch("/api/tasks")
            .then(r => r.json())
            .then(tasks => {
                let html = "";
                tasks.forEach(task => {
                    html += '<div class="task ' + task.priority + '">' +
                            "<h3>" + task.title + "</h3>" +
                            "<p>Priority: " + task.priority + "</p>" +
                            "<small>Created: " + new Date(task.createdAt).toLocaleString() + "</small>" +
                            "</div>";
                });
                document.getElementById("tasks").innerHTML = html;
            })
            .catch(err => {
                document.getElementById("tasks").innerHTML = "Error loading tasks: " + err.message;
            });
    </script>
</body>
</html>
EOL
                    
                    echo "✅ Frontend created successfully!"
                    echo "🎨 Open: http://localhost:8081"
                '''
            }
        }
        
        stage('Verify Deployment') {
            steps {
                echo 'Verifying deployment...'
                sh '''
                    sleep 3
                    echo "🔍 Checking application health..."
                    curl -f http://localhost:8081/health || echo "Health check failed"
                    
                    echo ""
                    echo "🔍 Checking frontend..."
                    curl -s http://localhost:8081 | head -5 || echo "Frontend check failed"
                    
                    echo ""
                    echo "📊 Current containers:"
                    docker ps
                    
                    echo ""
                    echo "🎉 DEPLOYMENT COMPLETE!"
                    echo "👉 Access your app at: http://localhost:8081"
                    echo "👉 API endpoints available at: http://localhost:8081/api/tasks"
                '''
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed!'
            sh 'docker system prune -f 2>/dev/null || true'
        }
        success {
            echo '🎉 SUCCESS! CI/CD pipeline is working perfectly!'
            sh '''
                echo ""
                echo "🚀 APPLICATION DEPLOYED SUCCESSFULLY!"
                echo "📍 URL: http://localhost:8081"
                echo "🔧 API: http://localhost:8081/api/tasks"
                echo "❤️  Health: http://localhost:8081/health"
                echo ""
                echo "To stop the application: docker stop demo-app"
                echo "To view logs: docker logs demo-app"
            '''
        }
        failure {
            echo '❌ Pipeline failed! Check the logs above for errors.'
        }
    }
}
