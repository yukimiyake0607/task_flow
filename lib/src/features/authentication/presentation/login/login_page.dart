import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/common_widgets/appbar/custom_appbar.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/extensions/snack_bar.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:todo_app/src/features/authentication/presentation/widgets/auth_button.dart';
import 'package:todo_app/src/routing/router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final controller = ref.read(authControllerProvider.notifier);
      await controller.signinWithEmailAndPassword(email, password);
    }
  }

  String _getErrorMessage(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('user-not-found')) {
      return 'このメールアドレスのアカウントが見つかりません。';
    } else if (errorString.contains('wrong-password') ||
        errorString.contains('invalid-credential')) {
      return 'パスワードが正しくありません。';
    } else if (errorString.contains('invalid-email')) {
      return 'メールアドレスの形式が正しくありません。';
    } else if (errorString.contains('too-many-requests')) {
      return 'ログイン試行回数が多すぎます。しばらくしてから再度お試しください。';
    } else if (errorString.contains('network-request-failed')) {
      return 'ネットワークエラーが発生しました。接続を確認してください。';
    } else {
      return 'ログインに失敗しました。入力内容をご確認ください。';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    ref.listen<AsyncValue>(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        final errorMessage = _getErrorMessage(next.error);
        context.showErrorSnackBar(errorMessage);
      } else if (next is AsyncData && next.value != null) {
        context.goNamed(AppRoute.home.name);
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'ログイン',
          isShowPopButton: true,
          subTitle: 'アカウント情報を入力してください',
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    onFieldSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.push('/forgot');
                      },
                      child: const Text(
                        'パスワードをお忘れですか？',
                        style: TextStyle(
                          color: todoMainColor,
                          decoration: TextDecoration.underline,
                          decorationColor: todoMainColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ログインボタン
                  AuthButton(
                    buttonTitle: 'ログイン',
                    onPressed: () {
                      if (!isLoading) {
                        _login();
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  const Text('アカウントをお持ちでない場合は'),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      context.push('/register');
                    },
                    child: const Text(
                      '新規登録',
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
