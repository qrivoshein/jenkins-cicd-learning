#!/bin/bash

echo "🚀 Настройка учебного проекта CI/CD с Jenkins"
echo "================================================"

# Проверяем наличие Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен. Установите Docker Desktop"
    exit 1
fi

# Проверяем наличие Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен. Установите Docker Compose"
    exit 1
fi

echo "✅ Docker и Docker Compose найдены"

# Создаем .env файл если его нет
if [ ! -f .env ]; then
    echo "📝 Создаем .env файл..."
    cat > .env << EOF
# Конфигурация для учебного проекта CI/CD
COMPOSE_PROJECT_NAME=jenkins-cicd-learning

# Jenkins
JENKINS_PORT=8080
JENKINS_ADMIN_USER=admin
JENKINS_ADMIN_PASSWORD=admin

# GitLab
GITLAB_PORT=8081
GITLAB_ROOT_PASSWORD=root1234

# Приложение
APP_DEV_PORT=3000
APP_STAGING_PORT=3001
APP_PROD_PORT=3002

# Nginx
NGINX_PORT=80
EOF
    echo "✅ .env файл создан"
fi

# Устанавливаем права на выполнение для скриптов
chmod +x scripts/*.sh

echo ""
echo "🔧 Настройка завершена!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Запустите проект: ./scripts/start.sh"
echo "2. Откройте Jenkins: http://localhost:8080"
echo "3. Откройте GitLab: http://localhost:8081"
echo "4. Откройте приложение: http://localhost:3000"
echo ""
echo "🔑 Логины по умолчанию:"
echo "- Jenkins: admin/admin"
echo "- GitLab: root/root1234"
echo ""
echo "📚 Документация: README.md"
