import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';
import 'package:minesweeper/ui/match_screen.dart';
import 'package:minesweeper/ui/start_screen.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Note: MyApp is a HookWidget, from flutter_hooks.
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // To read our provider, we can use the hook "useProvider".
    // This is only possible because MyApp is a HookWidget.
    final String value = useProvider(helloWorldProvider);

    return MaterialApp(
      routes: {
        '/': (context) => StartScreen(),
        '/match': (context) => MatchScreen(),
      },
      initialRoute: '/',
    );
  }
}
