import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/src/features/authentication/data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(email, password);
    });
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(email, password);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.signOut();
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final authRepository = ref.watch(authRepositoryProvider);
      await authRepository.sendPasswordResetEmail(email);
    });
  }
}
