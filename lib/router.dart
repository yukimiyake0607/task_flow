import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/pages/auth/login/forgot_password_page.dart';
import 'package:todo_app/presentation/pages/auth/login/login_page.dart';
import 'package:todo_app/presentation/pages/auth/register/register_page.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/pages/user_session/user_session_page.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  // 後で作成！
  initialLocation: '/',
  // パスと画面の組み合わせ
  routes: [
    GoRoute(
      name: 'user_session',
      path: '/',
      builder: (context, state) {
        return const UserSessionPage();
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
    GoRoute(
      name: 'forgot',
      path: '/forgot',
      builder: (context, state) {
        return const ForgotPasswordPage();
      },
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した場合に使用
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    );
  },
);
