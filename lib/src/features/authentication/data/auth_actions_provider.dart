import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository_impl.dart';
import 'package:todo_app/src/features/authentication/data/auth_provider.dart';
import 'package:todo_app/src/extensions/messages/auth_error_message.dart';

// AuthActionsを提供するプロバイダー
final authActionsProvider = Provider<AuthActions>((ref) {
  return AuthActions(ref);
});

// 認証に関する操作を提供：ユースケース
class AuthActions {
  final Ref _ref;

  AuthActions(this._ref);

  // メールとパスワードでサインイン
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(authActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(email, password);
      _ref.read(authActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess();
    } on FirebaseAuthException catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError(getErrorMessage(e));
    } on Exception catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError('エラーが発生しました');
    }
  }

  // メールとパスワードで会員登録
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(authActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(email, password);
      _ref.read(authActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess();
    } on FirebaseAuthException catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError(getErrorMessage(e));
    } on Exception catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError('エラーが発生しました');
    }
  }

  // サインアウト
  Future<void> signOut() async {
    _ref.read(authActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.signOut();
    } on Exception catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
    }
  }

  // パスワードリセットメールの送信
  Future<void> resetPassword(
    String email,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(authActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.sendPasswordResetEmail(email);
      _ref.read(authActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess();
    } on FirebaseAuthException catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError(getErrorMessage(e));
    } on Exception catch (e, stackTrace) {
      _ref.read(authActionStateProvider.notifier).state =
          AsyncValue.error(e, stackTrace);
      onError('エラーが発生しました');
    }
  }
}
