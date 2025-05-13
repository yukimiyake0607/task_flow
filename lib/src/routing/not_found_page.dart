import 'package:flutter/material.dart';
import 'package:todo_app/src/common_widgets/empty_placeholder_widget.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyPlaceholderWidget(message: '404 - ページが見つかりません'),
    );
  }
}