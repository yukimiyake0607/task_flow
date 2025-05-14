import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_page.dart';
import 'package:todo_app/src/features/authentication/presentation/login/forgot_password_page.dart';
import 'package:todo_app/src/features/authentication/presentation/login/login_page.dart';
import 'package:todo_app/src/features/authentication/presentation/register/register_page.dart';
import 'package:todo_app/src/features/home/home_page.dart';
import 'package:todo_app/src/features/profile/presentation/section_pages/email_setting_page.dart';
import 'package:todo_app/src/features/profile/presentation/section_pages/help_and_support_page.dart';
import 'package:todo_app/src/features/profile/presentation/section_pages/password_setting_page.dart';
import 'package:todo_app/src/features/profile/presentation/section_pages/terms_and_policies_page.dart';
import 'package:todo_app/src/routing/go_router_refresh_stream.dart';
import 'package:todo_app/src/routing/not_found_page.dart';

part 'router.g.dart';

enum AppRoute {
  home,
  auth,
  login,
  register,
  forgot,
  emailSetting,
  passwordSetting,
  termsPolicies,
  helpSupport,
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final currentUser = ref.watch(isSignedInProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final loggedIn = currentUser;
      final path = state.uri.path;
      if (loggedIn) {
        if (path.startsWith('/auth')) {
          return '/';
        }
      } else {
        if (path == '/' ||
            path == '/emailSetting' ||
            path == '/passwordSetting' ||
            path == '/termsPolicies' ||
            path == '/helpSupport') {
          return '/auth/login';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'emailSetting',
            name: AppRoute.emailSetting.name,
            builder: (context, state) => const EmailSettingPage(),
          ),
          GoRoute(
            path: 'passwordSetting',
            name: AppRoute.passwordSetting.name,
            builder: (context, state) => const PasswordSettingPage(),
          ),
          GoRoute(
            path: 'termsPolicies',
            name: AppRoute.termsPolicies.name,
            builder: (context, state) => const TermsAndPoliciesPage(),
          ),
          GoRoute(
            path: 'helpSupport',
            name: AppRoute.helpSupport.name,
            builder: (context, state) => const HelpAndSupportPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/auth',
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: 'register',
            name: AppRoute.register.name,
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'login',
            name: AppRoute.login.name,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: 'forgot',
            name: AppRoute.forgot.name,
            builder: (context, state) => const ForgotPasswordPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
