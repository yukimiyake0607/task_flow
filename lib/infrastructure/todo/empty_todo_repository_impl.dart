import 'package:todo_app/domain/entities/todo_model/todo_model.dart';
import 'package:todo_app/domain/repositories/todo_repository_interface.dart';

class EmptyTodoRepositoryImpl implements ITodoRepository {
  @override
  Stream<List<TodoModel>> getAllTodos() => Stream.value([]);

  @override
  Stream<List<TodoModel>> getCompletedTodo() => Stream.value([]);

  @override
  Stream<List<TodoModel>> getInCompletedTodo() => Stream.value([]);

  @override
  Future<String> addTodo(TodoModel todoModel) async => '';

  @override
  Future<void> updateTodo(TodoModel todoModel) async {}

  @override
  Future<void> deleteTodo(String id) async {}

  @override
  Future<void> setTodoCompleted(TodoModel todoModel, bool isCompleted) async {}
}