import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

/// Global variable holding a reference to our state object
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());
