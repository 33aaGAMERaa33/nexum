import 'dart:math';

class Offset {
  late final int leftPos;
  late final int topPos;

  Offset({
    required int leftPos,
    required int topPos,
  }) {
    this.leftPos = max(leftPos, 0);
    this.topPos = max(topPos, 0);
  }

  factory Offset.zero() {
    return Offset(leftPos: 0, topPos: 0);
  }

  bool isBefore(Offset other) {
    return leftPos < other.leftPos && topPos < other.topPos;
  }

  bool isAfter(Offset other) {
    return leftPos > other.leftPos && topPos > other.topPos;
  }

  @override
  String toString() => "Offset(leftPos: $leftPos, topPos: $topPos)";

  Offset operator +(Offset other) {
    return Offset(leftPos: leftPos + other.leftPos, topPos: topPos + other.topPos);
  }
}