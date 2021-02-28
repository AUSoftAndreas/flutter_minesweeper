import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';
import 'package:minesweeper/models/position.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

/// Central GUI Screen. Represents a playing field and handles user input
class MatchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    final field = useProvider(globFieldNotifier.state);
    final height = MediaQuery.of(context).size.height * 0.8;
    final width = MediaQuery.of(context).size.width;
    final max = height > width ? width : height;
    final orientation = MediaQuery.of(context).orientation;
    if (field.numCols == 0) {
      return _buildRestart(fieldNotifier);
    }
    return Material(
      child: Container(
        color: field.gameLost ? Colors.red[700] : Colors.grey[300],
        height: height,
        child: Flex(
          direction: orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: field.numCols,
                children: _buildBlocks(field, fieldNotifier),
              ),
            ),
            Flex(
              direction: Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: field.flagMode ? Colors.green : Colors.transparent,
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.flag),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.toggleFlagMode();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBlocks(Field field, FieldNotifier fieldNotifier) {
    final widgets = <Widget>[];
    for (var row = field.numRows - 1; row >= 0; row--) {
      for (var col = 0; col < field.numCols; col++) {
        final block = field.map[Position(col, row)];
        if (block != null) {
          widgets.add(
            InkWell(
              onTap: () {
                fieldNotifier.handleClick(block);
              },
              child: _buildBlock(block),
            ),
          );
        }
      }
    }
    return widgets;
  }

  Widget _buildBlock(Block block) {
    var color = Colors.transparent;
    if (block.open && !block.mine) {
      color = Colors.white;
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
      ),
      child: FittedBox(
        child: Center(
          child: _buildBlockCenter(block),
        ),
      ),
    );
  }

  Widget _buildBlockCenter(Block block) {
    var color = Colors.black;
    if (block.flagged) {
      return const Icon(Icons.flag);
    } else if (!block.open) {
      return const Text('');
    } else if (block.mine) {
      return const Text('M');
    } else {
      if (block.closeMines <= 2) {
        color = Colors.green;
      } else if (block.closeMines <= 4) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      return Text(
        block.closeMines == 0 ? '' : block.closeMines.toString(),
        style: TextStyle(
          color: color,
        ),
      );
    }
  }

  Material _buildRestart(FieldNotifier fieldNotifier) => Material(
        child: Container(
          color: Colors.grey[300],
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.replay),
              iconSize: 50,
              onPressed: () {
                fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
              },
            ),
          ),
        ),
      );
}
