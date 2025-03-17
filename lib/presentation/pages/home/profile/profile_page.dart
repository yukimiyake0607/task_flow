import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'プロフィール',
        isPositionCenter: false,
      ),
      body: Center(
        child: Text('設定画面を表示'),
      ),
    );
  }
}
