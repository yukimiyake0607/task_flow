import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/core/bottom_navigation/bottom_navigation_provider.dart';
import 'package:todo_app/src/core/bottom_navigation/bottom_navigation.dart';
import 'package:todo_app/src/features/completed/presentation/completed_page.dart';
import 'package:todo_app/src/features/profile/presentation/profile_page.dart';
import 'package:todo_app/src/features/todo/todo/todo_page.dart';

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
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
