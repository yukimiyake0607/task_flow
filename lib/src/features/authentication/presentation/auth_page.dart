import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/authentication/presentation/widgets/auth_button.dart';
import 'package:todo_app/src/features/authentication/presentation/widgets/auth_white_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.task_alt,
                color: todoMainColor,
                size: 180,
              ),
              const Text(
                'TaskFlow',
                style: TextStyle(
                  fontSize: 30,
                  color: todoMainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text('タスク管理をもっとシンプルに'),
              const SizedBox(height: 50),
              AuthButton(
                  buttonTitle: 'ログイン',
                  onPressed: () {
                    context.push('/login');
                  }),
              const SizedBox(height: 20),
              AuthWhiteButton(
                  buttonTitle: '新規登録',
                  onPressed: () {
                    context.push('/register');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
