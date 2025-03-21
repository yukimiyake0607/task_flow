import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/pages/auth/widgets/auth_button.dart';
import 'package:todo_app/presentation/providers/auth/auth_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() {}

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authActionStateProvider);
    final isLoading = authState is AsyncLoading;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'パスワードをリセット',
        isShowPopButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('パスワードリセットメールを送信します。'),
              const Text('登録したメールアドレスを入力してください。'),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'メールアドレスを入力してください';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return '有効なメールアドレスを入力してください';
                  }
                  return null;
                },
                enabled: !isLoading,
              ),
              const SizedBox(height: 32),
              AuthButton(
                buttonTitle: 'リセットメールを送信',
                onPressed: isLoading ? null : _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
