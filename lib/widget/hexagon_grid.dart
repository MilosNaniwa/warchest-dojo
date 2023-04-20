import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef HexagonWidgetBuilder = Widget Function(
  int coordinateX,
  int coordinateY,
  Offset centerOffset,
  double radius,
);

class HexagonGrid extends StatelessWidget {
  static const int nrX = 7;
  static const int nrY = 7;
  static const int marginY = 1;
  static const int marginX = 1;
  final double screenWidth;
  final double screenHeight;
  final double radius;
  final double height;
  final bool reversed;

  final HexagonWidgetBuilder builder;

  final List<Widget> hexagons = [];

  HexagonGrid({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.builder,
    required this.reversed,
  })  : radius = computeRadius(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        height = computeHeight(
          radius: computeRadius(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
        super(key: key) {
    for (int x = 0; x < nrX; x++) {
      for (int y = 0; y < nrY; y++) {
        hexagons.add(
          builder(
            x,
            y,
            computeCenter(
              x: x,
              y: y,
            ),
            radius,
          ),
        );
      }
    }
  }

  static double computeRadius({
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

  static double computeHeight({
    required double radius,
  }) {
    return heightRatioOfRadius() * radius * 2;
  }

  Offset computeCenter({
    required int x,
    required int y,
  }) {
    var centerX = computeX(
      x: x,
    );
    var centerY = computeY(
      x: x,
      y: y,
    );
    return Offset(centerX, centerY);
  }

  computeY({
    required int x,
    required int y,
  }) {
    double centerY;
    if (x % 2 == 0) {
      centerY = y * height + y * marginY + height / 2;
    } else {
      centerY = y * height + (y + 0.5) * marginY + height;
    }
    double marginsVertical = computeEmptySpaceY() / 2;
    return centerY + marginsVertical;
  }

  double computeEmptySpaceY() {
    return screenHeight - ((nrY - 1) * height + 1.5 * height + totalMarginY());
  }

  double computeX({
    required int x,
  }) {
    double marginsHorizontal = computeEmptySpaceX() / 2;
    return x * marginX + x * 1.5 * radius + radius + marginsHorizontal;
  }

  double computeEmptySpaceX() {
    return screenWidth - (totalMarginX() + (nrX - 1) * 1.5 * radius + 2 * radius);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: hexagons,
    );
  }
}
