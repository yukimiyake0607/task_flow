import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/pages/auth/widgets/auth_button.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'パスワードをリセット',
        isShowPopButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              const Text('パスワードリセットメールを送信します。'),
              const Text('登録したメールアドレスを入力してください。'),
              const SizedBox(height: 32),
              TextFormField(),
              const SizedBox(height: 32),
              AuthButton(
                buttonTitle: 'リセットメールを送信',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
