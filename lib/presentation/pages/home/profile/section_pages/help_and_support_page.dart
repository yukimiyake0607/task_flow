import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'ヘルプとサポート',
        isShowPopButton: true,
      ),
      body: Center(
        child: Text('ここに内容'),
      ),
    );
  }
}
