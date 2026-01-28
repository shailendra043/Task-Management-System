import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/features/tasks/data/repositories/task_repository.dart';
import 'package:task_app/features/tasks/domain/models/task_model.dart';

// Task Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

// Tasks List Provider (AsyncValue for loading states)
final tasksProvider =
    StateNotifierProvider<TasksNotifier, AsyncValue<List<TaskModel>>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TasksNotifier(repository);
});

// Task Filter State
enum TaskFilter { all, completed, pending }

// Task Filter Provider
final taskFilterProvider = StateProvider<TaskFilter>((ref) {
  return TaskFilter.all;
});

// Filtered Tasks Provider
final filteredTasksProvider = Provider<AsyncValue<List<TaskModel>>>((ref) {
  final tasks = ref.watch(tasksProvider);
  final filter = ref.watch(taskFilterProvider);

  return tasks.when(
    data: (taskList) {
      List<TaskModel> filtered;
      switch (filter) {
        case TaskFilter.completed:
          filtered = taskList.where((task) => task.isCompleted).toList();
          break;
        case TaskFilter.pending:
          filtered = taskList.where((task) => !task.isCompleted).toList();
          break;
        case TaskFilter.all:
          filtered = taskList;
      }
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Tasks Notifier
class TasksNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  final TaskRepository _repository;

  TasksNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  // Load all tasks
  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await _repository.getTasks();
      state = AsyncValue.data(tasks);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Create new task
  Future<void> createTask(String title, String description) async {
    try {
      await _repository.createTask(title, description);
      // Reload tasks after creation
      await loadTasks();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  // Update task
  Future<void> updateTask(String id, String title, String description) async {
    try {
      await _repository.updateTask(id, title, description);
      // Reload tasks after update
      await loadTasks();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    try {
      await _repository.deleteTask(id);
      // Reload tasks after deletion
      await loadTasks();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskStatus(String id) async {
    try {
      await _repository.toggleTaskStatus(id);
      // Reload tasks after toggling
      await loadTasks();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  // Refresh tasks (for pull-to-refresh)
  Future<void> refresh() async {
    await loadTasks();
  }
}
