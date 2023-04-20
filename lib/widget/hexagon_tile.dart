import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/widget/unit_coin.dart';

class HexagonTile extends StatelessWidget {
  final String tileName;
  final int coordinateX;
  final int coordinateY;
  final Offset centerOffset;
  final double radius;
  final void Function()? onTap;
  final void Function(bool) onHover;

  final bool isFocused;
  final bool isHovered;
  final String deployedUnitClass;
  final bool isMovable;
  final bool isAttackable;
  final bool isDeployable;
  final bool isInstructable;
  final bool isControlPoint;
  final String dominatedBy;
  final bool isOpponentUnit;
  final int hitPoint;

  const HexagonTile({
    Key? key,
    required this.tileName,
    required this.coordinateX,
    required this.coordinateY,
    required this.centerOffset,
    required this.radius,
    required this.onTap,
    required this.onHover,
    required this.hitPoint,
    this.isFocused = false,
    this.isHovered = false,
    this.deployedUnitClass = UnitClassConst.none,
    this.isMovable = false,
    this.isAttackable = false,
    this.isDeployable = false,
    this.isControlPoint = false,
    this.isInstructable = false,
    this.dominatedBy = HexagonConst.neutral,
    this.isOpponentUnit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((coordinateX == 0 && ([0, 1, 6].contains(coordinateY))) ||
        (coordinateX == 1 && ([0, 6].contains(coordinateY))) ||
        (coordinateX == 2 && ([0].contains(coordinateY))) ||
        (coordinateX == 4 && ([0].contains(coordinateY))) ||
        (coordinateX == 5 && ([0, 6].contains(coordinateY))) ||
        (coordinateX == 6 && ([0, 1, 6].contains(coordinateY)))) {
      return const SizedBox.shrink();
    } else {
      return Stack(
        children: [
          ClipPath(
            clipper: _HexagonClipper(
              coordinateX: coordinateX,
              coordinateY: coordinateY,
              centerOffset: centerOffset,
              radius: radius,
            ),
            child: InkWell(
              onTap: onTap,
              onHover: onHover,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                color: isControlPoint == true
                    ? dominatedBy == HexagonConst.neutral
                        ? Colors.grey
                        : dominatedBy == HexagonConst.playerBlue
                            ? Colors.cyan
                            : Colors.purpleAccent
                    : Colors.amber,
              ),
            ),
          ),
          CustomPaint(
            painter: _HexagonPainter(
              tileName: tileName,
              coordinateX: coordinateX,
              coordinateY: coordinateY,
              centerOffset: centerOffset,
              radius: radius,
              isFocused: isFocused,
              isHovered: isHovered,
              deployedUnitClass: deployedUnitClass,
              isMovable: isMovable,
              isAttackable: isAttackable,
              isDeployable: isDeployable,
              isInstructable: isInstructable,
              isOpponentUnit: isOpponentUnit,
            ),
          ),
          Visibility(
            visible: globalKanjiMode == false && deployedUnitClass != UnitClassConst.none,
            child: Positioned(
              left: centerOffset.dx - radius / 2,
              top: centerOffset.dy - radius / 2,
              child: InkWell(
                onTap: onTap,
                child: SizedBox(
                  height: radius,
                  width: radius,
                  child: RotatedBox(
                    quarterTurns: isOpponentUnit ? 2 : 0,
                    child: Image.asset(
                      "assets/units/$deployedUnitClass.png",
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: deployedUnitClass != UnitClassConst.none,
            child: CustomPaint(
              painter: UnitCoinPainter(
                centerOffset: centerOffset,
                radius: radius,
                deployedUnitClass: deployedUnitClass,
                isOpponentUnit: isOpponentUnit,
                hitPoint: hitPoint,
                kanjiMode: globalKanjiMode,
              ),
            ),
          ),
        ],
      );
    }
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  final int coordinateX;
  final int coordinateY;
  final Offset centerOffset;
  final double radius;

  _HexagonClipper({
    required this.coordinateX,
    required this.coordinateY,
    required this.centerOffset,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final path = createHexagonPath(
      center: centerOffset,
      radius: radius,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _HexagonPainter extends CustomPainter {
  final String tileName;
  final int coordinateX;
  final int coordinateY;
  final Offset centerOffset;
  final double radius;
  final bool isFocused;
  final bool isHovered;
  final String deployedUnitClass;
  final bool isMovable;
  final bool isAttackable;
  final bool isDeployable;
  final bool isInstructable;
  final bool isOpponentUnit;

  _HexagonPainter({
    required this.tileName,
    required this.coordinateX,
    required this.coordinateY,
    required this.centerOffset,
    required this.radius,
    required this.isFocused,
    required this.isHovered,
    required this.deployedUnitClass,
    required this.isMovable,
    required this.isAttackable,
    required this.isDeployable,
    required this.isInstructable,
    required this.isOpponentUnit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawTileId(
      canvas: canvas,
    );

    if (isFocused == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.blue,
      );
    }

    if (isHovered == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.tealAccent,
      );
    }

    if (isDeployable == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.greenAccent,
      );
    }

    if (isMovable == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.greenAccent,
      );
    }

    if (isAttackable == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.red,
      );
    }

    if (isInstructable == true) {
      _drawHexagonWithOpacity(
        canvas: canvas,
        color: Colors.blueAccent,
      );
    }
  }

  void _drawTileId({
    required Canvas canvas,
  }) {
    final span = TextSpan(
      style: TextStyle(
        fontSize: radius * 0.18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      text: tileName,
    );
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        centerOffset.dx - (textPainter.width / 2),
        centerOffset.dy - (radius / 1.25),
      ),
    );
  }

  void _drawHexagonWithOpacity({
    required Canvas canvas,
    required Color color,
  }) {
    Paint paint = Paint();
    paint.color = color.withOpacity(0.5);
    final path = createHexagonPath(
      center: centerOffset,
      radius: radius,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Path createHexagonPath({
  required double radius,
  required Offset center,
}) {
  final path = Path();
  const angle = (math.pi * 2) / 6;
  Offset firstPoint = Offset(
    radius * math.cos(0.0),
    radius * math.sin(0.0),
  );
  path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
  for (int i = 1; i <= 6; i++) {
    double x = radius * math.cos(angle * i) + center.dx;
    double y = radius * math.sin(angle * i) + center.dy;
    path.lineTo(x, y);
  }
  path.close();

  return path;
}
