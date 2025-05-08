import 'package:flutter/material.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/sign_out_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SignOutDialog();
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
