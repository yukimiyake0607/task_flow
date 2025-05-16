import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/common_widgets/appbar/custom_appbar.dart';
import 'package:todo_app/src/common_widgets/error_page.dart';
import 'package:todo_app/src/common_widgets/loading_page.dart';
import 'package:todo_app/src/features/todo/data/todo_provider.dart';
import 'package:todo_app/src/features/todo/presentation/todo_card.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeTodoListAsync = ref.watch(completeTodoProvider);
    return Scaffold(
      appBar: const CustomAppBar(
        title: '完了タスク',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: completeTodoListAsync.when(
          data: (completeTodoList) {
            if (completeTodoList.isEmpty) {
              return const Center(child: Text('完了したTodoはありません'));
            }
            return ListView.builder(
                itemCount: completeTodoList.length,
                itemBuilder: (context, index) {
                  final completeTodo = completeTodoList[index];
                  return TodoCard(
                    key: ValueKey(completeTodo.id),
                    todoModel: completeTodo,
                  );
                });
          },
          error: (error, stackTrace) => ErrorPage(error: error),
          loading: () => const LoadingPage(),
        ),
      ),
    );
  }
}
