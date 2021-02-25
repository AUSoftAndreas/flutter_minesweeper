import 'package:flutter/material.dart';

/// Welcome Screen for the app
class StartScreen extends StatelessWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
