# Учебный проект CI/CD с Jenkins

Этот проект предназначен для обучения основам Continuous Integration и Continuous Deployment с использованием Jenkins.

## Описание проекта

Проект представляет собой простое веб-приложение "Task Manager" с возможностью:
- Создавать задачи
- Отмечать выполненные задачи
- Управлять приоритетами

## Структура проекта

```
jenkins-cicd-learning/
├── app/                    # Веб-приложение
├── jenkins/               # Конфигурация Jenkins
├── docker/                # Docker конфигурация
├── kubernetes/            # Kubernetes манифесты
└── scripts/               # Скрипты для автоматизации
```

## Стенды для практики

1. **Development** - стенд для разработки
2. **Staging** - стенд для тестирования
3. **Production** - продакшн стенд

## Задачи для практики

1. Настройка Jenkins pipeline
2. Автоматический билд приложения
3. Запуск тестов
4. Деплой на разные стенды
5. Настройка уведомлений
6. Работа с артефактами

## Запуск проекта

```bash
# Запуск Jenkins
docker-compose up -d jenkins

# Запуск приложения
docker-compose up -d app

# Запуск всех сервисов
docker-compose up -d
```

## Доступ к сервисам

- Jenkins: http://localhost:8080
- Приложение: http://localhost:3000
- GitLab: http://localhost:8081

## Логины по умолчанию

- Jenkins: admin/admin
- GitLab: root/root1234
