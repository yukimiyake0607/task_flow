import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/pages/auth/auth_page.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/providers/auth/auth_provider.dart';

class UserSessionPage extends ConsumerWidget {
  const UserSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    return user.when(
      data: (user) {
        return user != null ? const HomePage() : const AuthPage();
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
