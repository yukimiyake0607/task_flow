import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auth Page'),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  child: const Text('新規登録'),
                ),
                TextButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text('ログイン'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
