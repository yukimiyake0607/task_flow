import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/constants/textstyles.dart';
import 'package:todo_app/src/features/profile/presentation/widgets/show_logout_dialog_button.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('ログアウト', style: Textstyles.titleMedium),
      titlePadding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      content: const Text(
        'ログアウトしてもよろしいですか？',
        style: Textstyles.bodyNote,
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
      actions: const [
        LogoutCancelButton(),
        ConfirmLogoutButton(),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
