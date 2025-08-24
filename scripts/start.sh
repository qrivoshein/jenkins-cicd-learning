#!/bin/bash

echo "🚀 Запуск учебного проекта CI/CD с Jenkins"
echo "==========================================="

# Проверяем наличие .env файла
if [ ! -f .env ]; then
    echo "❌ .env файл не найден. Запустите сначала ./scripts/setup.sh"
    exit 1
fi

# Загружаем переменные окружения
source .env

echo "📦 Запускаем все сервисы..."

# Останавливаем существующие контейнеры
echo "🛑 Останавливаем существующие контейнеры..."
docker-compose down

# Удаляем старые образы (опционально)
read -p "🗑️ Удалить старые Docker образы? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Удаляем старые образы..."
    docker system prune -f
fi

# Запускаем все сервисы
echo "🚀 Запускаем сервисы..."
docker-compose up -d

# Ждем запуска сервисов
echo "⏳ Ждем запуска сервисов..."
sleep 30

# Проверяем статус сервисов
echo "🔍 Проверяем статус сервисов..."
docker-compose ps

echo ""
echo "🎉 Проект запущен!"
echo ""
echo "🔗 Доступные сервисы:"
echo "- Jenkins: http://localhost:${JENKINS_PORT:-8080}"
echo "- GitLab: http://localhost:${GITLAB_PORT:-8081}"
echo "- Приложение (Dev): http://localhost:${APP_DEV_PORT:-3000}"
echo "- Приложение (Staging): http://localhost:${APP_STAGING_PORT:-3001}"
echo "- Приложение (Prod): http://localhost:${APP_PROD_PORT:-3002}"
echo "- Nginx: http://localhost:${NGINX_PORT:-80}"
echo ""
echo "🔑 Логины по умолчанию:"
echo "- Jenkins: ${JENKINS_ADMIN_USER:-admin}/${JENKINS_ADMIN_PASSWORD:-admin}"
echo "- GitLab: root/${GITLAB_ROOT_PASSWORD:-root1234}"
echo ""
echo "📋 Полезные команды:"
echo "- Просмотр логов: docker-compose logs -f [service_name]"
echo "- Остановка: docker-compose down"
echo "- Перезапуск: docker-compose restart [service_name]"
echo "- Обновление: ./scripts/update.sh"
