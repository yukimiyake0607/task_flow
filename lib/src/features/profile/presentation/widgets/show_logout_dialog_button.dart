import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:todo_app/src/routing/router.dart';

class ShowLogoutDialogButton extends StatelessWidget {
  const ShowLogoutDialogButton({super.key});

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const LogoutDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // ログアウト処理
          _showSignOutDialog(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'ログアウト',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6B6B),
          ),
        ),
      ),
    );
  }
}

class ConfirmLogoutButton extends ConsumerWidget {
  const ConfirmLogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          context.pop();
          await ref.read(authControllerProvider.notifier).signOut();
          if (context.mounted) {
            context.goNamed(AppRoute.auth.name);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5722),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'ログアウト',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class LogoutCancelButton extends StatelessWidget {
  const LogoutCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          context.pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          elevation: 0,
          side: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'キャンセル',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
