import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';

class StartScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    return Material(
      child: Container(
        child: Center(
          child: IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
              Navigator.pushNamed(context, '/match');
            },
          ),
        ),
      ),
    );
  }
}
