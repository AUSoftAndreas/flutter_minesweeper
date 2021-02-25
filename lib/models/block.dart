import 'package:minesweeper/models/position.dart';

class Block {
  Position position;
  bool mine;
  bool flagged = false;
  int closeMines = 0;
  bool open = false;

  Block({required this.position, this.mine = false});

  List<Block> neighbors(Map<Position, Block> map) {
    var list = <Block>[];
    if (map[Position(position.x + 0, position.y + 1)] != null) list.add(map[Position(position.x + 0, position.y + 1)]!);
    if (map[Position(position.x + 1, position.y + 1)] != null) list.add(map[Position(position.x + 1, position.y + 1)]!);
    if (map[Position(position.x + 1, position.y + 0)] != null) list.add(map[Position(position.x + 1, position.y + 0)]!);
    if (map[Position(position.x + 1, position.y - 1)] != null) list.add(map[Position(position.x + 1, position.y - 1)]!);
    if (map[Position(position.x + 0, position.y - 1)] != null) list.add(map[Position(position.x + 0, position.y - 1)]!);
    if (map[Position(position.x - 1, position.y - 1)] != null) list.add(map[Position(position.x - 1, position.y - 1)]!);
    if (map[Position(position.x - 1, position.y + 0)] != null) list.add(map[Position(position.x - 1, position.y + 0)]!);
    if (map[Position(position.x - 1, position.y + 1)] != null) list.add(map[Position(position.x - 1, position.y + 1)]!);
    return list;
  }

  void updateCloseMines(Map<Position, Block> map) {
    neighbors(map).forEach((block) {
      if (block.mine) closeMines++;
    });
  }

  void reveal(Map<Position, Block> map) {
    open = true;
    if (mine) return;
    if (closeMines == 0) {
      neighbors(map).forEach((block) {
        if (!block.open) {
          block.reveal(map);
        }
      });
    }
  }
}
