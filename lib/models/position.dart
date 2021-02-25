class Position {
  int x;
  int y;

  Position(this.x, this.y);

  String toString() => 'Position($x/$y)';

  bool operator ==(o) => o is Position && o.x == x && o.y == y;
  int get hashCode => 1000 * x + y;
}
