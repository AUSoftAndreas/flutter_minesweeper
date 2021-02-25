import 'package:flutter/material.dart';
import 'package:minesweeper/ui/start_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

/// Base class of app
class MyApp extends StatelessWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => StartScreen(),
      },
      initialRoute: '/',
    );
  }
}
