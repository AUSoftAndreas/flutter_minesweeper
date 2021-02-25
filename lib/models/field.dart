import 'dart:developer';
import 'dart:math' as math;

import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/position.dart';

class Field {
  late final Map<Position, Block> map;
  final int mines;
  final int numRows;
  final int numCols;
  final bool gameLost;
  final bool flagMode;

  Field()
      : map = {},
        mines = 0,
        numRows = 0,
        numCols = 0,
        gameLost = false,
        flagMode = false;

  Field.withArguments({required this.numRows, required this.numCols, required this.mines})
      : gameLost = false,
        flagMode = false {
    Map<Position, Block> newMap = {};
    var leftMines = mines;
    var leftFields = numRows * numCols;
    var rng = math.Random();
    for (var col = 0; col < numCols; col++) {
      for (var row = 0; row < numRows; row++) {
        var pos = Position(col, row);
        var prob = (100 * leftMines) ~/ leftFields;
        var mine = rng.nextInt(100) < prob;
        newMap[pos] = Block(position: pos, mine: mine);
        //log('Field(): field created at $pos with chance $prob: ${mine ? 'with' : 'without'} mine');
        if (mine) {
          leftMines--;
        }
        leftFields--;
        // if (mine) {
        //   log('Field(): $leftMines mines to go in $leftFields fields');
        // }
      }
    }
    // Let each field calculate its nearby mines
    newMap.forEach((pos, block) {
      block.updateCloseMines(newMap);
    });

    map = newMap;
  }

  Field._internal({
    required this.map,
    required this.mines,
    required this.numRows,
    required this.numCols,
    required this.gameLost,
    required this.flagMode,
  });

  Field copyWith({Map<Position, Block>? map, int? mines, int? numRows, int? numCols, bool? gameLost, bool? flagMode}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? this.mines,
        numRows: numRows ?? this.numRows,
        numCols: numCols ?? this.numCols,
        gameLost: gameLost ?? this.gameLost,
        flagMode: flagMode ?? this.flagMode,
      );
}
