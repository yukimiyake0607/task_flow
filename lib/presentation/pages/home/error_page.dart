import 'package:flutter/widgets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$error'));
  }
}
