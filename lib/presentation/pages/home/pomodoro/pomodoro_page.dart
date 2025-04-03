import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'ポモドーロ'),
      body: Center(
        child: Text('ここにタイマー'),
      ),
    );
  }
}
