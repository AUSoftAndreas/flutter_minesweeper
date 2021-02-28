import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Settings {
/*-----------------------------------------------------------------------------\
| Constants                                                                    |
\-----------------------------------------------------------------------------*/
  /// Standard number of columns
  static const stdCols = 10;

  /// Minimum number of columns
  static const stdColsMin = 4;

  /// Maximum number of columns
  static const stdColsMax = 30;

  /// Standard number of rows
  static const stdRows = 10;

  /// Minimum number of rows
  static const stdRowsMin = 4;

  /// Maximum number of rows
  static const stdRowsMax = 30;

  /// Standard percentage of mines on field
  static const stdMinePercentage = 15;

  /// Minimum percentage of mines on field
  static const stdMinePercentageMin = 5;

  /// Maximum percentage of mines on field
  static const stdMinePercentageMax = 50;

/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  final int _rows;

  final int _cols;

  final int _minePercentage;

/*-----------------------------------------------------------------------------\
| Getters / Setters for attributes                                             |
\-----------------------------------------------------------------------------*/
  int get rows => _rows;
  int get cols => _cols;
  int get minePercentage => _minePercentage;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  Settings()
      : _rows = stdRows,
        _cols = stdCols,
        _minePercentage = stdMinePercentage;

  Settings._internal({required int rows, required int cols, required int minePercentage})
      : _rows = rows,
        _cols = cols,
        _minePercentage = minePercentage;

/*-----------------------------------------------------------------------------\
| Methods                                                                      |
\-----------------------------------------------------------------------------*/
  Settings copyWith({int? rows, int? cols, int? minePercentage}) => Settings._internal(
        cols: cols ?? _cols,
        rows: rows ?? _rows,
        minePercentage: minePercentage ?? _minePercentage,
      );
}
