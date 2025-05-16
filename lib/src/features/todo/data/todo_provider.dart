import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:todo_app/src/features/todo/data/todo_repository_impl.dart';

// 未完了Todoを監視するストリームプロバイダー
final incompleteTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getInCompletedTodo();
});

// 完了したTodoを監視するストリームプロバイダー
final completeTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getCompletedTodo();
});

// すべてのTodoを監視するストリームプロバイダー
final allTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getAllTodos();
});
