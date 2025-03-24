import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/pages/home/error_page.dart';
import 'package:todo_app/presentation/pages/home/loading_page.dart';
import 'package:todo_app/presentation/pages/home/todo/widgets/todo_card.dart';
import 'package:todo_app/presentation/providers/todo/todo_provider.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeTodoListAsync = ref.watch(completeTodoProvider);
    return Scaffold(
      appBar: const CustomAppBar(
        title: '完了タスク',
      ),
      body: completeTodoListAsync.when(
        data: (completeTodoList) {
          if (completeTodoList.isEmpty) {
            return const Center(child: Text('完了したTodoはありません'));
          }
          return ListView.builder(
              itemCount: completeTodoList.length,
              itemBuilder: (context, index) {
                final completeTodo = completeTodoList[index];
                return TodoCard(todoModel: completeTodo);
              });
        },
        error: (error, stackTrace) => ErrorPage(error: error),
        loading: () => const LoadingPage(),
      ),
    );
  }
}
