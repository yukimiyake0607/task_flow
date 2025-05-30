import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/constants/todo_theme.dart';
import 'package:todo_app/src/features/authentication/presentation/auth_controller.dart';

class AuthButton extends ConsumerWidget {
  final String _buttonTitle;
  final VoidCallback _onPressed;

  const AuthButton({
    super.key,
    required String buttonTitle,
    required VoidCallback onPressed,
  })  : _buttonTitle = buttonTitle,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    final isLoading = controller is AsyncLoading;
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: todoMainColor,
      ),
      child: ElevatedButton(
        onPressed: () {
          _onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                _buttonTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
