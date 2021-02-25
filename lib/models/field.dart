import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/position.dart';

@immutable

/// Class representing the game field
class Field {
  /// A map (associative array), linking each Position to its corresponding block.
  late final Map<Position, Block> map;

  /// Number of mines on the field
  final int mines;

  /// Number of rows
  final int numRows;

  /// Number of columns
  final int numCols;

  /// Is the game already lost?
  final bool gameLost;

  /// Will the next click of the user plant a flag (instead of opening a block)?
  final bool flagMode;

  /// Constructs a game field for our game
  /// It is an empty field. We just use it for instantiating the game in
  /// lib/notifiers/_notfifiers.dart. It will be reconstructed many times using
  /// the .withArguments constructor.
  Field()
      : map = {},
        mines = 0,
        numRows = 0,
        numCols = 0,
        gameLost = false,
        flagMode = false;

  /// Constructs a game field for our game
  Field.withArguments({required this.numRows, required this.numCols, required this.mines})
      : gameLost = false,
        flagMode = false {
    final newMap = <Position, Block>{};
    var leftMines = mines;
    var leftFields = numRows * numCols;
    final rng = math.Random();
    for (var col = 0; col < numCols; col++) {
      for (var row = 0; row < numRows; row++) {
        final pos = Position(col, row);
        final prob = (100 * leftMines) ~/ leftFields;
        final mine = rng.nextInt(100) < prob;
        newMap[pos] = Block(position: pos, mine: mine);
        if (mine) {
          leftMines--;
        }
        leftFields--;
      }
    }
    // Let each field calculate its nearby mines
    newMap.forEach((pos, block) {
      block.updateCloseMines(newMap);
    });
    map = newMap;
  }

  // ignore: prefer_const_constructors_in_immutables
  Field._internal({
    required this.map,
    required this.mines,
    required this.numRows,
    required this.numCols,
    required this.gameLost,
    required this.flagMode,
  });

  /// Returns new Field object, which is a copy of this object, but with
  /// some differences specified when calling this method.
  Field copyWith({Map<Position, Block>? map, int? mines, int? numRows, int? numCols, bool? gameLost, bool? flagMode}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? this.mines,
        numRows: numRows ?? this.numRows,
        numCols: numCols ?? this.numCols,
        gameLost: gameLost ?? this.gameLost,
        flagMode: flagMode ?? this.flagMode,
      );
}
