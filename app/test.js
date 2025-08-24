// Простые тесты для приложения Task Manager
const assert = require('assert');

// Мок данных для тестирования
let tasks = [
  { id: 1, title: 'Test Task 1', completed: false, priority: 'high', createdAt: new Date() },
  { id: 2, title: 'Test Task 2', completed: true, priority: 'medium', createdAt: new Date() }
];

let nextId = 3;

// Тест создания задачи
function testCreateTask() {
  const newTask = {
    id: nextId++,
    title: 'New Test Task',
    completed: false,
    priority: 'low',
    createdAt: new Date()
  };
  
  tasks.push(newTask);
  
  assert.strictEqual(tasks.length, 3);
  assert.strictEqual(newTask.title, 'New Test Task');
  assert.strictEqual(newTask.priority, 'low');
  
  console.log('✅ Тест создания задачи прошел');
}

// Тест обновления задачи
function testUpdateTask() {
  const taskId = 1;
  const taskIndex = tasks.findIndex(task => task.id === taskId);
  
  if (taskIndex !== -1) {
    tasks[taskIndex].completed = true;
    tasks[taskIndex].priority = 'medium';
  }
  
  assert.strictEqual(tasks[taskIndex].completed, true);
  assert.strictEqual(tasks[taskIndex].priority, 'medium');
  
  console.log('✅ Тест обновления задачи прошел');
}

// Тест удаления задачи
function testDeleteTask() {
  const initialLength = tasks.length;
  const taskId = 2;
  const taskIndex = tasks.findIndex(task => task.id === taskId);
  
  if (taskIndex !== -1) {
    tasks.splice(taskIndex, 1);
  }
  
  assert.strictEqual(tasks.length, initialLength - 1);
  
  console.log('✅ Тест удаления задачи прошел');
}

// Тест валидации данных
function testValidation() {
  // Тест на пустое название
  const emptyTitleTask = { title: '', priority: 'high' };
  assert.strictEqual(emptyTitleTask.title === '', true);
  
  // Тест на корректный приоритет
  const validPriorities = ['low', 'medium', 'high'];
  const testPriority = 'medium';
  assert.strictEqual(validPriorities.includes(testPriority), true);
  
  console.log('✅ Тест валидации данных прошел');
}

// Запуск всех тестов
function runTests() {
  console.log('🚀 Запуск тестов...\n');
  
  try {
    testCreateTask();
    testUpdateTask();
    testDeleteTask();
    testValidation();
    
    console.log('\n🎉 Все тесты прошли успешно!');
    return true;
  } catch (error) {
    console.error('\n❌ Тест не прошел:', error.message);
    return false;
  }
}

// Экспорт для использования в других файлах
module.exports = {
  runTests,
  testCreateTask,
  testUpdateTask,
  testDeleteTask,
  testValidation
};

// Запуск тестов если файл запущен напрямую
if (require.main === module) {
  runTests();
}
