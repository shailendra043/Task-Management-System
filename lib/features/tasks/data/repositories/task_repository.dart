import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/features/tasks/domain/models/task_model.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TaskRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // Helper to get the current user's task collection
  CollectionReference<Map<String, dynamic>> get _tasksCollection {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks');
  }

  /// Get all tasks stream
  Stream<List<TaskModel>> getTasksStream() {
    try {
      return _tasksCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          try {
            return TaskModel(
              id: doc.id,
              title: data['title'] ?? '',
              description: data['description'] ?? '',
              isCompleted: data['isCompleted'] ?? false,
              createdAt: (data['createdAt'] as Timestamp).toDate(),
              updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
            );
          } catch (e) {
            // Skip malformed documents instead of crashing entire stream
            return null;
          }
        }).whereType<TaskModel>().toList(); // Filter out nulls
      });
    } on FirebaseException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to fetch tasks stream: $e');
    }
  }

  /// Create a new task
  Future<TaskModel> createTask(String title, String description) async {
    try {
      final now = DateTime.now();
      final taskData = {
        'title': title,
        'description': description,
        'isCompleted': false,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      final docRef = await _tasksCollection.add(taskData);

      return TaskModel(
        id: docRef.id,
        title: title,
        description: description,
        isCompleted: false,
        createdAt: now,
        updatedAt: now,
      );
    } on FirebaseException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  /// Update an existing task
  Future<TaskModel> updateTask(
    String id,
    String title,
    String description,
  ) async {
    try {
      final now = DateTime.now();
      final updates = {
        'title': title,
        'description': description,
        'updatedAt': Timestamp.fromDate(now),
      };

      await _tasksCollection.doc(id).update(updates);
      return (await getTaskById(id))!; 
    } on FirebaseException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  /// Delete a task
  Future<void> deleteTask(String id) async {
    try {
      await _tasksCollection.doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  /// Toggle task completion status
  Future<TaskModel> toggleTaskStatus(String id) async {
    try {
      final docRef = _tasksCollection.doc(id);
      
      return await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        
        if (!snapshot.exists) {
          throw Exception('Task not found');
        }

        final data = snapshot.data()!;
        final currentStatus = data['isCompleted'] as bool? ?? false;
        final newStatus = !currentStatus;
        final now = DateTime.now();

        transaction.update(docRef, {
          'isCompleted': newStatus,
          'updatedAt': Timestamp.fromDate(now),
        });

        return TaskModel(
          id: id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          isCompleted: newStatus,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          updatedAt: now,
        );
      });
    } on FirebaseException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to toggle task: $e');
    }
  }

  /// Get a single task by ID
  Future<TaskModel?> getTaskById(String id) async {
    try {
      final doc = await _tasksCollection.doc(id).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return TaskModel(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        isCompleted: data['isCompleted'] ?? false,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      );
    } catch (e) {
      return null;
    }
  }

  String _getFriendlyErrorMessage(FirebaseException e) {
    if (e.code == 'permission-denied') {
      return 'Access denied: You do not have permission to access this data.';
    } else if (e.code == 'unavailable') {
      return 'Service unavailable: Please check your internet connection.';
    } else if (e.code == 'not-found') {
      return 'Data not found.';
    }
    return e.message ?? 'An unexpected error occurred.';
  }
}
