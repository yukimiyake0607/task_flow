import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/core/extensions/snack_bar.dart';
import 'package:todo_app/presentation/core/theme/todo_card_color.dart';
import 'package:todo_app/presentation/pages/auth/widgets/auth_button.dart';
import 'package:todo_app/presentation/providers/auth/auth_actions_provider.dart';
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

  Future<void> _resetPassword() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final email = _emailController.text.trim();

      await ref.read(authActionsProvider).resetPassword(
        email,
        () {
          context.showSuccessSnackBar('パスワードリセットのメールを送信しました');
          context.pop();
        },
        (errorMessage) {
          context.showErrorSnackBar(errorMessage);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authActionStateProvider);
    final isLoading = authState is AsyncLoading;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'パスワードをリセット',
        subTitle: 'メールアドレスを入力してリンクを送信',
        isShowPopButton: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(
                    Icons.task_alt,
                    color: todoMainColor,
                    size: 100,
                  ),
                  const SizedBox(height: 30),
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
                    onPressed: () {
                      if (!isLoading) {
                        _resetPassword();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
