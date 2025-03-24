import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/pages/home/error_page.dart';
import 'package:todo_app/presentation/pages/home/loading_page.dart';
import 'package:todo_app/presentation/pages/home/todo/widgets/todo_card.dart';
import 'package:todo_app/presentation/pages/home/todo/widgets/todo_dialog.dart';
import 'package:todo_app/presentation/providers/todo/todo_provider.dart';

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
      appBar: const CustomAppBar(
        title: 'マイタスク',
        subTitle: 'タスクが3件残っています',
      ),
      body: inCompleteTodoListAsync.when(
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
                return TodoCard(todoModel: inCompleteTodo);
              });
        },
        error: (error, stackTrace) => ErrorPage(error: error),
        loading: () => const LoadingPage(),
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
