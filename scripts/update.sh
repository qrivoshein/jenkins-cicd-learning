#!/bin/bash

echo "🔄 Обновление учебного проекта CI/CD с Jenkins"
echo "==============================================="

# Проверяем наличие .env файла
if [ ! -f .env ]; then
    echo "❌ .env файл не найден. Запустите сначала ./scripts/setup.sh"
    exit 1
fi

# Загружаем переменные окружения
source .env

echo "📦 Обновляем проект..."

# Останавливаем сервисы
echo "🛑 Останавливаем сервисы..."
docker-compose down

# Обновляем образы
echo "🔄 Обновляем Docker образы..."
docker-compose pull

# Пересобираем приложение
echo "🏗️ Пересобираем приложение..."
docker-compose build --no-cache app-dev app-staging app-prod

# Запускаем обновленные сервисы
echo "🚀 Запускаем обновленные сервисы..."
docker-compose up -d

# Ждем запуска
echo "⏳ Ждем запуска сервисов..."
sleep 30

# Проверяем статус
echo "🔍 Проверяем статус сервисов..."
docker-compose ps

echo ""
echo "✅ Проект обновлен!"
echo ""
echo "🔗 Доступные сервисы:"
echo "- Jenkins: http://localhost:${JENKINS_PORT:-8080}"
echo "- GitLab: http://localhost:${GITLAB_PORT:-8081}"
echo "- Приложение (Dev): http://localhost:${APP_DEV_PORT:-3000}"
echo "- Приложение (Staging): http://localhost:${APP_STAGING_PORT:-3001}"
echo "- Приложение (Prod): http://localhost:${APP_PROD_PORT:-3002}"
