#!/bin/bash

echo "🛑 Остановка учебного проекта CI/CD с Jenkins"
echo "=============================================="

# Проверяем наличие .env файла
if [ ! -f .env ]; then
    echo "❌ .env файл не найден"
    exit 1
fi

# Загружаем переменные окружения
source .env

echo "🛑 Останавливаем все сервисы..."

# Останавливаем и удаляем контейнеры
docker-compose down

# Удаляем тома (опционально)
read -p "🗑️ Удалить все тома (данные будут потеряны)? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Удаляем тома..."
    docker-compose down -v
    docker volume prune -f
fi

# Удаляем образы (опционально)
read -p "🗑️ Удалить Docker образы? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Удаляем образы..."
    docker-compose down --rmi all
fi

echo ""
echo "✅ Проект остановлен!"
echo ""
echo "📋 Для повторного запуска используйте: ./scripts/start.sh"
