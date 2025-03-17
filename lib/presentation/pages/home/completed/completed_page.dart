import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/core/appbar/custom_appbar.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: '完了タスク',
        isPositionCenter: false,
      ),
    );
  }
}
