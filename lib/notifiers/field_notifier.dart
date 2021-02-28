import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class FieldNotifier extends StateNotifier<Field> {
  /// Constructor (from Riverpod tutorial)
  FieldNotifier() : super(Field());

  /// Creates a new playing field ... just by instantiating a new state
  /// with a new playing field
  void create({required int numRows, required int numCols, required int mines}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, mines: mines);
  }

  /// Is triggered by users clicking on a certain block in the game (MatchScreen)
  void handleClick(Block block) {
    if (state.gameLost) {
      return;
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

  /// Is triggered by the user clicking on the toggle switch for flag mode
  /// If the user is in flag mode, he will mark suspected bomb locations,
  /// instead of openig a tile.
  void toggleFlagMode() {
    state = state.copyWith(flagMode: !state.flagMode);
  }
}
