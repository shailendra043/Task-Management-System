import 'package:task_app/core/network/api_client.dart';

import 'package:task_app/features/tasks/domain/models/task_model.dart';

class TaskRepository {


  // Mock tasks database (simulating backend)
  static final List<TaskModel> _mockTasks = [];
  static int _taskIdCounter = 1;

  TaskRepository({ApiClient? apiClient});

  /// Get all tasks
  /// In production, this would call GET /tasks
  Future<List<TaskModel>> getTasks() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return copy of tasks list (sorted by creation date, newest first)
    return List<TaskModel>.from(_mockTasks)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Create a new task
  /// In production, this would call POST /tasks
  Future<TaskModel> createTask(String title, String description) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    final task = TaskModel(
      id: (_taskIdCounter++).toString(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    _mockTasks.add(task);
    return task;
  }

  /// Update an existing task
  /// In production, this would call PUT /tasks/:id
  Future<TaskModel> updateTask(
    String id,
    String title,
    String description,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 600));

    final index = _mockTasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      throw Exception('Task not found');
    }

    final updatedTask = _mockTasks[index].copyWith(
      title: title,
      description: description,
      updatedAt: DateTime.now(),
    );

    _mockTasks[index] = updatedTask;
    return updatedTask;
  }

  /// Delete a task
  /// In production, this would call DELETE /tasks/:id
  Future<void> deleteTask(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _mockTasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      throw Exception('Task not found');
    }

    _mockTasks.removeAt(index);
  }

  /// Toggle task completion status
  /// In production, this would call PATCH /tasks/:id
  Future<TaskModel> toggleTaskStatus(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _mockTasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      throw Exception('Task not found');
    }

    final updatedTask = _mockTasks[index].copyWith(
      isCompleted: !_mockTasks[index].isCompleted,
      updatedAt: DateTime.now(),
    );

    _mockTasks[index] = updatedTask;
    return updatedTask;
  }

  /// Get a single task by ID
  Future<TaskModel?> getTaskById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _mockTasks.firstWhere((task) => task.id == id);
    } catch (_) {
      return null;
    }
  }
}
