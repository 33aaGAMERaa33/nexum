class EdgeInsets {
  final int top;
  final int right;
  final int bottom;
  final int left;

  int get horizontalSize => left + right;
  int get verticalSize => top + bottom;

  const EdgeInsets.only({
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
  });

  const EdgeInsets.all(int value) :
        top = value,
        right = value,
        bottom = value,
        left = value;

  const EdgeInsets.symetric({int horizontal = 0, int vertical = 0}) :
        top= vertical,
        right= horizontal,
        bottom= vertical,
        left= horizontal;
}