import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

final helloWorldProvider = Provider((_) => 'Hello world');
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());
