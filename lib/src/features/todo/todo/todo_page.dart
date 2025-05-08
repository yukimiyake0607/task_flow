import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/appbar/custom_appbar.dart';
import 'package:todo_app/src/common_widgets/error_page.dart';
import 'package:todo_app/src/common_widgets/loading_page.dart';
import 'package:todo_app/src/features/todo/todo/widgets/todo_card.dart';
import 'package:todo_app/src/features/todo/todo/widgets/todo_dialog.dart';
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
        padding: const EdgeInsets.all(16),
        child: inCompleteTodoListAsync.when(
          data: (inCompleteTodoList) {
            if (inCompleteTodoList.isEmpty) {
              return const Center(
                child: Text('Todoがありません。'),
              );
            }
            return ListView.builder(
                itemCount: inCompleteTodoList.length,
                itemBuilder: (context, index) {
                  final inCompleteTodo = inCompleteTodoList[index];
                  return TodoCard(
                    key: ValueKey(inCompleteTodo.id),
                    todoModel: inCompleteTodo,
                  );
                });
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
