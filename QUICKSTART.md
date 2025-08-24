# 🚀 Быстрый старт проекта CI/CD

Этот файл содержит пошаговые инструкции для быстрого запуска учебного проекта CI/CD.

## ⚡ Быстрый запуск (5 минут)

### 1. Клонирование и настройка
```bash
# Перейдите в директорию проекта
cd jenkins-cicd-learning

# Запустите настройку
./scripts/setup.sh

# Запустите все сервисы
./scripts/start.sh
```

### 2. Проверка доступности
Откройте в браузере:
- **Jenkins**: http://localhost:8080 (admin/admin)
- **GitLab**: http://localhost:8081 (root/StrongPassword123!)
- **Приложение**: http://localhost:3000

### 3. Инициализация Git
```bash
# Инициализируйте Git репозиторий
./scripts/init-git.sh
```

## 🐳 Что запускается

### Сервисы:
- **Jenkins** (порт 8080) - CI/CD сервер
- **GitLab** (порт 8081) - Git репозиторий
- **Task Manager App** - веб-приложение на 3 стендах:
  - Development (порт 3000)
  - Staging (порт 3001)
  - Production (порт 3002)
- **Nginx** (порт 80) - балансировщик нагрузки

### Стенды:
- **Development** - для разработки и тестирования
- **Staging** - для предпродакшн тестирования
- **Production** - продакшн среда

## 🔧 Основные команды

```bash
# Запуск всех сервисов
./scripts/start.sh

# Остановка всех сервисов
./scripts/stop.sh

# Обновление проекта
./scripts/update.sh

# Просмотр статуса
docker-compose ps

# Просмотр логов
docker-compose logs -f [service_name]

# Перезапуск сервиса
docker-compose restart [service_name]
```

## 📱 Первое приложение

### 1. Откройте http://localhost:3000
### 2. Создайте новую задачу
### 3. Отметьте задачу как выполненную
### 4. Удалите задачу

## 🎯 Первый Pipeline

### 1. Войдите в Jenkins (admin/admin)
### 2. Создайте новый Pipeline job
### 3. Скопируйте код из `jenkins/jobs/task-manager-pipeline/config.xml`
### 4. Запустите pipeline

## 🚨 Решение проблем

### Сервис не запускается:
```bash
# Проверьте логи
docker-compose logs [service_name]

# Перезапустите сервис
docker-compose restart [service_name]

# Проверьте статус
docker-compose ps
```

### Порт занят:
```bash
# Остановите все сервисы
./scripts/stop.sh

# Запустите заново
./scripts/start.sh
```

### Проблемы с правами:
```bash
# Установите права на выполнение
chmod +x scripts/*.sh
```

## 📚 Следующие шаги

1. **Изучите структуру проекта** - README.md
2. **Выполните практические задания** - EXERCISES.md
3. **Настройте Git репозиторий** в GitLab
4. **Создайте Jenkins pipeline**
5. **Попробуйте автоматический деплой**

## 🔗 Полезные ссылки

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Docker Documentation](https://docs.docker.com/)
- [GitLab Documentation](https://docs.gitlab.com/)

## 💡 Советы

- Используйте `docker-compose logs -f` для просмотра логов в реальном времени
- Проверяйте статус сервисов командой `docker-compose ps`
- Все изменения в коде автоматически отражаются в development стенде
- Используйте разные браузеры или режим инкогнито для тестирования разных стендов

**Готово! Теперь у вас есть полноценная среда для изучения CI/CD! 🎉**
