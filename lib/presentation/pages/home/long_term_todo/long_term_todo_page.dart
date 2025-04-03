import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class LongTermTodoPage extends StatelessWidget {
  const LongTermTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: '長期目標'),
      body: Center(
        child: Text('ここにリスト作成'),
      ),
    );
  }
}
