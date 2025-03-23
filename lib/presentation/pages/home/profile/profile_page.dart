import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/providers/auth/auth_actions_provider.dart';
import 'package:todo_app/presentation/providers/auth/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
        },
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'プロフィール',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザー情報表示（デバッグ用）
            Consumer(
              builder: (context, ref, _) {
                final authState = ref.watch(authStateProvider);
                return Text(
                  'ユーザー: ${authState.valueOrNull?.email ?? "未ログイン"}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () => showSignOutDialog(),
              icon: const Icon(Icons.logout, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
