import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/common_widgets/appbar/custom_appbar.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:todo_app/src/features/authentication/presentation/widgets/auth_button.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // キーボードを閉じる
      FocusScope.of(context).unfocus();

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final authState = ref.watch(authControllerProvider);

      if (authState is AsyncLoading) {
        return; // すでにローディング中なら何もしない
      }

      final controller = ref.read(authControllerProvider.notifier);
      await controller.createUserWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アカウント作成に失敗しました')),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '新規登録',
          isShowPopButton: true,
          subTitle: '新しいアカウントを作成',
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
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
                  // メールアドレス入力
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

                  const SizedBox(height: 20),

                  // パスワード入力
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value.length < 6) {
                        return 'パスワードは6文字以上で入力してください';
                      }
                      return null;
                    },
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 20),

                  // パスワード再入力
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'パスワード確認',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      if (value != _passwordController.text) {
                        return 'パスワードが一致しません';
                      }
                      return null;
                    },
                    enabled: !isLoading,
                  ),

                  const SizedBox(height: 32),

                  // 登録ボタン
                  AuthButton(
                    buttonTitle: '新規登録',
                    onPressed: () {
                      if (!isLoading) {
                        _register();
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  const Text('すでにアカウントをお持ちの場合は'),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      context.push('/login');
                    },
                    child: const Text(
                      'ログイン',
                      style: TextStyle(
                        color: todoMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
