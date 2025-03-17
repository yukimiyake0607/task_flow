import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/pages/auth_page.dart';
import 'package:todo_app/presentation/pages/login_page.dart';
import 'package:todo_app/presentation/pages/register_page.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  // 後で作成！
  initialLocation: '/',
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      path: '/',
      name: 'auth',
      builder: (context, state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),
  ],
  // 繊維ページがないなどのエラーが発生した場合に使用
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    );
  },
);
