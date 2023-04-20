import 'dart:math' as math;

class PaintComputer {
  static const int nrX = 7;
  static const int nrY = 7;
  static const int marginY = 1;
  static const int marginX = 1;

  double computeRadius({
    required double screenWidth,
    required double screenHeight,
  }) {
    final maxWidth = (screenWidth - totalMarginX()) / (((nrX - 1) * 1.5) + 2);
    final maxHeight = 0.5 * (screenHeight - totalMarginY()) / (heightRatioOfRadius() * (nrY + 0.5));
    return math.min(maxWidth, maxHeight);
  }

  static double heightRatioOfRadius() => math.cos(math.pi / 6);

  static double totalMarginY() => (nrY - 0.5) * marginY;

  static int totalMarginX() => (nrX - 1) * marginX;

  double computeHeight({
    required double radius,
  }) {
    return heightRatioOfRadius() * radius * 2;
  }
}
