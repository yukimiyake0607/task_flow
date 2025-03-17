import 'package:flutter/material.dart';
import 'package:todo_app/presentation/core/theme/todo_card_color.dart';
import 'package:todo_app/router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      title: 'My ToDo!!',
      theme: ThemeData(
        primaryColor: todoMainColor,
        colorScheme: const ColorScheme.light(
          primary: todoMainColor,
          secondary: todoSubColor,
          surface: Colors.white,
        ),
      ),
    );
  }
}
