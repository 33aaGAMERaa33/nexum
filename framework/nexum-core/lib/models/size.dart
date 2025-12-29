class Size {
  final int width;
  final int height;
  const Size({required this.width, required this.height});

  Size operator +(Size other) {
    return Size(width: width + other.width, height: height + other.height);
  }

  @override
  String toString() => "Size(width: $width, height: $height)";
}