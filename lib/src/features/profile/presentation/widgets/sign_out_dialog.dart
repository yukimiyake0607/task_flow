import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/features/authentication/data/auth_actions_provider.dart';
import 'package:todo_app/src/features/authentication/data/auth_provider.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('ログアウト'),
      content: const Text('ログアウトしてもよろしいですか？'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () async {
            context.pop();
            await ref.read(authActionsProvider).signOut();
            if (context.mounted) {
              ref.read(authActionStateProvider.notifier).state =
                  const AsyncData(null);
              context.go('/auth');
            }
          },
          child: const Text('ログアウト'),
        ),
      ],
    );
  }
}