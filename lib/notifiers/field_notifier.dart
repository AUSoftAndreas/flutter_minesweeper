import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';

class FieldNotifier extends StateNotifier<Field> {
  FieldNotifier() : super(Field());

  void create({required numRows, required numCols, required mines}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, mines: mines);
  }

  void handleClick(Block block) {
    if (state.gameLost) {
      //return; // TODO: Wieder rein nehmen
    }
    if (state.flagMode) {
      block.flagged = !block.flagged;
      state = state.copyWith();
      return;
    }
    if (block.open) return;
    block.reveal(state.map);
    if (block.mine) {
      state.map.forEach(
        (pos, block) {
          if (block.mine) block.open = true;
        },
      );
      state = state.copyWith(gameLost: true);
      return;
    }
    state = state.copyWith();
  }

  void toggleFlagMode() {
    state = state.copyWith(flagMode: !state.flagMode);
  }
}
