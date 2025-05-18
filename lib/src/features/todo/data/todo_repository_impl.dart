import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/features/todo/data/interface/todo_repository_interface.dart';
import 'package:todo_app/src/features/todo/data/empty_todo_repository_impl.dart';

final todoRepositoryProvider = Provider<ITodoRepository>((ref) {
  final userIdAsyncValue = ref.watch(currentUserIdProvider);

  return userIdAsyncValue.when(
    data: (userId) => TodoRepository(userId: userId),
    error: (error, stackTrace) => EmptyTodoRepositoryImpl(),
    loading: () => EmptyTodoRepositoryImpl(),
  );
});

class TodoRepository implements ITodoRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'todos';
  final String? _userId;

  TodoRepository({FirebaseFirestore? firestore, required String? userId})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _userId = userId;

  CollectionReference<Map<String, dynamic>> get _todoCollectionRef {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }
    return _firestore.collection('users/$_userId/$_collection');
  }

  @override
  Stream<List<TodoModel>> getAllTodos() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todoCollectionRef
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Stream<List<TodoModel>> getCompletedTodo() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todoCollectionRef
        .where('isCompleted', isEqualTo: true)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Stream<List<TodoModel>> getInCompletedTodo() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todoCollectionRef
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Future<String> addTodo(TodoModel todoModel) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    await _todoCollectionRef
        .doc(todoModel.id)
        .set(TodoModel.toFirestore(todoModel));
    return todoModel.id;
  }

  @override
  Future<void> updateTodo(TodoModel todoModel) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    await _todoCollectionRef
        .doc(todoModel.id)
        .update(TodoModel.toFirestore(todoModel));
  }

  @override
  Future<void> deleteTodo(String id) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    await _todoCollectionRef.doc(id).delete();
  }

  @override
  Future<void> toggleTodo(TodoModel todo) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _todoCollectionRef
        .doc(todo.id)
        .update(TodoModel.toFirestore(updatedTodo));
  }
}
