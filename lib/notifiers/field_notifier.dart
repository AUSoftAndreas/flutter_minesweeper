import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class FieldNotifier extends StateNotifier<Field> {
  /// Standard constructor
  FieldNotifier() : super(Field());

  /// Creates a new playing field ... just by instantiating a new state
  /// with a new playing field
  void create({required int numRows, required int numCols, required int mines}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, mines: mines);
  }

  /// Handles click events from GUI.
  void handleClick(Block block) {
    if (state.gameLost) return;
    if (state.flagMode) {
      block.flagged = !block.flagged;
      state = state.copyWith();
      return;
    }
    if (block.flagged) return;
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

  /// Toggles Flag Mode. Enabled flag mode means that the user does not
  /// want to open a block, but rather to just plant a flag because
  /// he suspects a bomb there.
  void toggleFlagMode() {
    state = state.copyWith(flagMode: !state.flagMode);
  }
}
