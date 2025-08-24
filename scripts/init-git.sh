#!/bin/bash

echo "📚 Инициализация Git репозитория для обучения CI/CD"
echo "===================================================="

# Проверяем наличие Git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен. Установите Git"
    exit 1
fi

# Инициализируем Git репозиторий если его нет
if [ ! -d .git ]; then
    echo "📁 Инициализируем Git репозиторий..."
    git init
    echo "✅ Git репозиторий инициализирован"
else
    echo "✅ Git репозиторий уже существует"
fi

# Создаем .gitignore файл
echo "📝 Создаем .gitignore файл..."
cat > .gitignore << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
logs
*.log

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# nyc test coverage
.nyc_output

# Dependency directories
jspm_packages/

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Docker
.dockerignore

# Jenkins
jenkins_home/
jobs/
workspace/

# Temporary files
*.tmp
*.temp
artifacts/
EOF

echo "✅ .gitignore файл создан"

# Добавляем все файлы в Git
echo "📦 Добавляем файлы в Git..."
git add .

# Создаем первый коммит
echo "💾 Создаем первый коммит..."
git commit -m "🎉 Инициализация учебного проекта CI/CD с Jenkins

- Создано веб-приложение Task Manager
- Настроен Jenkins с pipeline
- Настроены Docker контейнеры
- Созданы стенды: Development, Staging, Production
- Добавлены скрипты автоматизации"

echo ""
echo "🎉 Git репозиторий готов!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Добавьте удаленный репозиторий: git remote add origin <your-repo-url>"
echo "2. Отправьте код: git push -u origin main"
echo "3. Настройте webhook в GitLab для автоматического запуска Jenkins"
echo ""
echo "🔗 Полезные команды Git:"
echo "- git status - проверить статус"
echo "- git log --oneline - история коммитов"
echo "- git branch - список веток"
echo "- git checkout -b feature/new-feature - создать новую ветку"
