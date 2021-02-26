import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minesweeper/ui/start_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Base class for the entire app
class MyApp extends HookWidget {
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
