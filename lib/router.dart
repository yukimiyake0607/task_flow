import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/pages/auth/auth_page.dart';
import 'package:todo_app/presentation/pages/auth/login/forgot_password_page.dart';
import 'package:todo_app/presentation/pages/auth/login/login_page.dart';
import 'package:todo_app/presentation/pages/auth/register/register_page.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/pages/home/profile/section_pages/email_setting.dart';
import 'package:todo_app/presentation/pages/user_session/user_session_page.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/',

  // 認証状態に基づくリダイレクト
  redirect: (BuildContext context, GoRouterState state) {
    // 現在のユーザー状態を取得
    final isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    final path = state.uri.path;

    // ユーザーがログインしていない場合、ログイン画面へリダイレクト
    // ただし、既にログイン関連のページにいる場合はリダイレクトしない
    if (!isLoggedIn &&
        path != '/login' &&
        path != '/register' &&
        path != '/forgot') {
      return '/auth';
    }

    // ユーザーがログイン済みで、ログイン関連のページにアクセスしようとした場合、ホーム画面へリダイレクト
    if (isLoggedIn &&
        (path == '/login' ||
            path == '/register' ||
            path == '/forgot' ||
            path == '/auth')) {
      return '/home';
    }

    // その他の場合は通常のルーティング
    return null;
  },

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
      name: 'auth',
      path: '/auth',
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
    GoRoute(
      name: 'email_setting',
      path: '/email_setting',
      builder: (context, state) {
        return const EmailSettingPage();
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
