import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/bottom_navigation/bottom_navigation_provider.dart';
import 'package:todo_app/presentation/core/bottom_navigation/bottom_navigation.dart';
import 'package:todo_app/presentation/pages/home/completed/completed_page.dart';
import 'package:todo_app/presentation/pages/home/long_term_todo/long_term_todo_page.dart';
import 'package:todo_app/presentation/pages/home/pomodoro/pomodoro_page.dart';
import 'package:todo_app/presentation/pages/home/profile/profile_page.dart';
import 'package:todo_app/presentation/pages/home/todo/todo_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationNum = ref.watch(bottomNavigationProvider);
    return Scaffold(
      body: IndexedStack(
        index: bottomNavigationNum,
        children: const [
          TodoPage(),
          CompletedPage(),
          LongTermTodoPage(),
          PomodoroPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
