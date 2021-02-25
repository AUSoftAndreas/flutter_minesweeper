// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:minesweeper/main.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  test('Field should be created and have the right number of fields/mines', () {
    final fieldNotifier = FieldNotifier();
    // ignore: cascade_invocations
    fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
    // ignore: invalid_use_of_protected_member
    final state = fieldNotifier.state;
    var numMines = 0;
    var numFields = 0;
    var numFlags = 0;
    state.map.forEach((pos, block) {
      numFields++;
      if (block.mine) numMines++;
      if (block.flagged) numFlags++;
    });
    expect(numMines, 20);
    expect(numFields, 100);
    expect(numFlags, 0);
  });
}
