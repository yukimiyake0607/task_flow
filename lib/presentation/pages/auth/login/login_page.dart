import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';
import 'package:todo_app/presentation/core/theme/todo_card_color.dart';
import 'package:todo_app/presentation/pages/auth/widgets/auth_button.dart';
import 'package:todo_app/presentation/providers/auth/auth_provider.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authActionStateProvider);
    final isLoading = authState is AsyncLoading;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'ログイン',
          isShowPopButton: true,
          subTitle: 'アカウント情報を入力してください',
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constrains) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constrains.maxHeight,
                  ),
                  child: Center(
                    child: Column(
                      children: [
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
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
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

                        // 登録ボタン
                        AuthButton(
                          buttonTitle: 'ログイン',
                          onPressed: () {},
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
