import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ログイン',
        isPositionCenter: true,
        subTitle: 'アカウント情報を入力してください',
      ),
    );
  }
}
