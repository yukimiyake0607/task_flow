import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/providers/auth/auth_actions_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showSignOutDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('ログアウト'),
              content: const Text('ログアウトしてもよろしいですか？'),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                    ref.read(authActionsProvider).signOut();
                  },
                  child: const Text('ログアウト'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'プロフィール',
      ),
      body: Center(
        child: IconButton(
          onPressed: () => showSignOutDialog(),
          icon: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
