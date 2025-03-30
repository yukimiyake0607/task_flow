import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
          surface: Colors.white,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'), // 日本語
        Locale('en', 'US'), // 英語
      ],
      locale: const Locale('ja', 'JP'), // デフォルトを日本語に設定
    );
  }
}
