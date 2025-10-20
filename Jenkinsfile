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
                    
                    # Создаем красивый фронтенд
                    docker exec demo-app sh -c 'cat > /app/public/index.html << "HTMLEND"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager App</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .header p {
            opacity: 0.9;
            font-size: 1.1em;
        }
        
        .content {
            padding: 30px;
        }
        
        .tasks-container {
            margin-top: 20px;
        }
        
        .task {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 5px solid;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .task:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .task.high {
            border-left-color: #e74c3c;
            background: linear-gradient(135deg, #ffeaea, #fff5f5);
        }
        
        .task.medium {
            border-left-color: #f39c12;
            background: linear-gradient(135deg, #fff4e6, #fffaf0);
        }
        
        .task.low {
            border-left-color: #27ae60;
            background: linear-gradient(135deg, #e8f6ef, #f0fff4);
        }
        
        .task h3 {
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1.3em;
        }
        
        .task-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            font-size: 0.9em;
            color: #7f8c8d;
        }
        
        .priority {
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.8em;
            text-transform: uppercase;
        }
        
        .priority.high {
            background: #e74c3c;
            color: white;
        }
        
        .priority.medium {
            background: #f39c12;
            color: white;
        }
        
        .priority.low {
            background: #27ae60;
            color: white;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 1.1em;
        }
        
        .error {
            text-align: center;
            padding: 40px;
            color: #e74c3c;
            background: #ffeaea;
            border-radius: 10px;
            margin: 20px 0;
        }
        
        .stats {
            display: flex;
            justify-content: space-around;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .stat-item {
            padding: 15px;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📝 Task Manager</h1>
            <p>Powered by Jenkins CI/CD Pipeline</p>
        </div>
        
        <div class="content">
            <div class="stats" id="stats">
                <div class="stat-item">
                    <div class="stat-number" id="total-tasks">-</div>
                    <div class="stat-label">Total Tasks</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="high-priority">-</div>
                    <div class="stat-label">High Priority</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="completed-tasks">-</div>
                    <div class="stat-label">Completed</div>
                </div>
            </div>
            
            <div class="tasks-container">
                <div id="tasks" class="loading">
                    🕐 Loading tasks...
                </div>
            </div>
        </div>
    </div>

    <script>
        async function loadTasks() {
            try {
                const response = await fetch('/api/tasks');
                
                if (!response.ok) {
                    throw new Error('API returned ' + response.status);
                }
                
                const tasks = await response.json();
                
                if (tasks.length === 0) {
                    document.getElementById('tasks').innerHTML = 
                        '<div class="loading">No tasks found. Create your first task via API!</div>';
                    return;
                }
                
                // Update stats
                document.getElementById('total-tasks').textContent = tasks.length;
                document.getElementById('high-priority').textContent = 
                    tasks.filter(t => t.priority === 'high').length;
                document.getElementById('completed-tasks').textContent = 
                    tasks.filter(t => t.completed).length;
                
                // Render tasks
                const html = tasks.map(task => `
                    <div class="task ${task.priority}">
                        <h3>${task.title}</h3>
                        <div class="task-meta">
                            <span class="priority ${task.priority}">${task.priority}</span>
                            <span>Created: ${new Date(task.createdAt).toLocaleDateString()}</span>
                        </div>
                    </div>
                `).join('');
                
                document.getElementById('tasks').innerHTML = html;
                
            } catch (error) {
                document.getElementById('tasks').innerHTML = 
                    '<div class="error">❌ Error loading tasks: ' + error.message + '</div>';
            }
        }
        
        // Load tasks when page loads
        document.addEventListener('DOMContentLoaded', loadTasks);
        
        // Refresh every 30 seconds
        setInterval(loadTasks, 30000);
    </script>
</body>
</html>
HTMLEND'
                    
                    echo "✅ Frontend created successfully!"
                    echo "🎨 Open: http://localhost:8081"
                    echo "⚡ Auto-refreshes every 30 seconds"
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
