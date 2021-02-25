import 'package:flutter/foundation.dart';

/// Defines an absolute position (of a block)
@immutable
class Position {
  /// Horizontal component of position, from 0 (left) to numCols-1 (right)
  final int x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  final int y;

  /// Standard constructor for position
  const Position(this.x, this.y);

  /// Overridden toString method, for better output instead of "Instance of <Posiion>"
  @override
  String toString() => 'Position($x/$y)';

  @override
  bool operator ==(Object o) => o is Position && o.x == x && o.y == y;

  @override
  int get hashCode => 1000 * x + y;
}
