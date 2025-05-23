import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/common_widgets/appbar/custom_appbar.dart';
import 'package:todo_app/src/common_widgets/error_page.dart';
import 'package:todo_app/src/common_widgets/loading_page.dart';
import 'package:todo_app/src/extensions/snack_bar.dart';
import 'package:todo_app/src/features/todo/presentation/incompleted/todo_list_widget.dart';
import 'package:todo_app/src/features/todo/presentation/todo_controller.dart';
import 'package:todo_app/src/features/todo/presentation/todo_dialog.dart';
import 'package:todo_app/src/features/todo/data/todo_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final inCompleteTodoListAsync = ref.watch(incompleteTodoProvider);

    ref.listen<AsyncValue>(todoControllerProvider, (previous, next) {
      if (next is AsyncError) {
        context.showErrorSnackBar('エラーが発生しました');
      }
    });

    return Scaffold(
      appBar: inCompleteTodoListAsync.when(
        data: (todoList) {
          final todoCount = todoList.length;
          return CustomAppBar(
            title: 'マイタスク',
            subTitle: todoCount > 0 ? 'タスクが$todoCount件残っています' : 'タスクはありません',
          );
        },
        error: (error, stackTrace) {
          return const CustomAppBar(
            title: 'マイタスク',
            subTitle: 'タスクの取得に失敗しました',
          );
        },
        loading: () {
          return const CustomAppBar(
            title: 'マイタスク',
            subTitle: 'タスクを取得中です',
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: inCompleteTodoListAsync.when(
          data: (todos) {
            return todos.isEmpty
                ? const Center(
                    child: Text('Todoがありません'),
                  )
                : TodoListWidget(todos: todos);
          },
          error: (error, stackTrace) => ErrorPage(error: error),
          loading: () => const LoadingPage(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const TodoDialog(buttonTitle: '追加');
            },
          );
        },
      ),
    );
  }
}
