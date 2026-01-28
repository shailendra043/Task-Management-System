import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_app/features/tasks/data/repositories/task_repository.dart';
import 'package:task_app/features/tasks/domain/models/task_model.dart';

import 'package:task_app/features/auth/providers/auth_providers.dart';

// Task Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

// Tasks List Provider (AsyncValue for loading states)
final tasksProvider =
    StateNotifierProvider.autoDispose<TasksNotifier, AsyncValue<List<TaskModel>>>((ref) {
  // Watch auth state to rebuild when user changes
  ref.watch(authStateProvider);
  
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
  StreamSubscription<List<TaskModel>>? _tasksSubscription;

  TasksNotifier(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    try {
      _tasksSubscription = _repository.getTasksStream().listen(
        (tasks) {
          state = AsyncValue.data(tasks);
        },
        onError: (error) {
          state = AsyncValue.error(error, StackTrace.current);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }

  // Reload/Refresh is now automatic via Stream, 
  // but we keep this for manual triggers if needed (e.g. error retry)
  Future<void> loadTasks() async {
     // Re-initialize stream if needed
     await _tasksSubscription?.cancel();
     _init();
  }
  
  // Create new task
  Future<void> createTask(String title, String description) async {
    try {
      await _repository.createTask(title, description);
      // No need to reload, stream updates automatically
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  // Update task
  Future<void> updateTask(String id, String title, String description) async {
    try {
      await _repository.updateTask(id, title, description);
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    try {
      await _repository.deleteTask(id);
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskStatus(String id) async {
    try {
      await _repository.toggleTaskStatus(id);
    } catch (error, stackTrace) {
      rethrow;
    }
  }

  // Refresh tasks (for pull-to-refresh)
  Future<void> refresh() async {
    await loadTasks();
  }
}
