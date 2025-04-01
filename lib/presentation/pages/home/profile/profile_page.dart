import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/pages/home/profile/widgets/sign_out_dialog.dart';
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
          return const SignOutDialog();
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
