import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/constants/textstyles.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:todo_app/src/routing/router.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('ログアウト', style: Textstyles.titleMedium),
      content: const Text(
        'ログアウトしてもよろしいですか？',
        style: Textstyles.bodyNote,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () async {
            context.pop();
            await ref.read(authControllerProvider.notifier).signOut();
            if (context.mounted) {
              context.goNamed(AppRoute.auth.name);
            }
          },
          child: const Text('ログアウト'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
