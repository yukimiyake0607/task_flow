import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/todo/data/todo_provider.dart';
import 'package:todo_app/src/features/todo/data/todo_repository_impl.dart';
import 'package:todo_app/src/features/todo/domain/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'todo_controller.g.dart';

@riverpod
class TodoController extends _$TodoController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> addTodo(
    String todoTitle,
    DateTime? dueDate,
    bool important,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      final newTodo = TodoModel(
        id: const Uuid().v4(),
        todoTitle: todoTitle,
        dueDate: dueDate,
        createdDate: DateTime.now(),
        important: important,
        isCompleted: false,
      );

      await repository.addTodo(newTodo);
    });
  }

  Future<void> deleteTodo(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.deleteTodo(id);
    });
  }

  Future<void> updateTodo(
    String todoTitle,
    DateTime? dueDate,
    bool important,
    String id,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);

      // 現在の未完了Todoを取得
      final incompletedTodos = await ref.read(incompleteTodoProvider.future);
      final todo = incompletedTodos.firstWhere((todo) => todo.id == id);

      final updateTodo = todo.copyWith(
        todoTitle: todoTitle,
        dueDate: dueDate,
        important: important,
        id: id,
      );

      await repository.updateTodo(updateTodo);
    });
  }

  Future<void> toggleTodo(TodoModel todo) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.toggleTodo(todo);
    });
  }
}
