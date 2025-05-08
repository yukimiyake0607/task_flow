import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/core/appbar/custom_appbar.dart';
import 'package:todo_app/src/core/extensions/snack_bar.dart';
import 'package:todo_app/src/core/theme/todo_theme.dart';
import 'package:todo_app/src/features/authentication/presentation/widgets/auth_button.dart';
import 'package:todo_app/src/features/authentication/data/auth_actions_provider.dart';
import 'package:todo_app/src/features/authentication/data/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    // 初期表示時に認証状態を確認
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isSignedIn = ref.read(isSignedInProvider);
      if (isSignedIn && mounted) {
        context.go('/home');
      }
    });
  }

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

      final authState = ref.read(authActionStateProvider);
      if (authState is AsyncLoading) {
        return; // すでにローディング中なら何もしない
      }

      try {
        // 認証処理を直接呼び出し、結果を待機
        await ref.read(authActionsProvider).signInWithEmailAndPassword(
          email,
          password,
          () {
            // ログイン成功時のコールバック
            if (mounted) {
              // このコールバックが呼ばれた時点で、Firebaseの認証状態は既に変わっているはず
              context.go('/home');
            }
          },
          (errorMessage) {
            // エラー時の処理
            if (mounted) {
              context.showErrorSnackBar(errorMessage);
            }
          },
        );

        // コールバックとは別に、この時点で認証状態を直接確認
        if (mounted) {
          final isSignedIn = ref.read(isSignedInProvider);
          if (isSignedIn) {
            context.go('/home');
          }
        }
      } on Exception catch (e) {
        // 想定外のエラー処理
        if (mounted) {
          context.showErrorSnackBar('ログイン中にエラーが発生しました: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authActionStateProvider);
    final isLoading = authState is AsyncLoading;

    // isSignedInProviderの変更を監視
    ref.listen<bool>(isSignedInProvider, (previous, current) {
      if (previous == false && current == true && mounted) {
        // サインイン状態が変わった場合
        context.go('/home');
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
