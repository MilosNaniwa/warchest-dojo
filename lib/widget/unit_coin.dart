import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/const/unit_spec.dart';
import 'package:warchest_dojo/global.dart';

class UnitCoinClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width,
        ),
      );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class UnitCoinPainter extends CustomPainter {
  final Offset centerOffset;
  final double radius;
  final String deployedUnitClass;
  final bool isOpponentUnit;
  final int hitPoint;
  final bool kanjiMode;

  UnitCoinPainter({
    required this.centerOffset,
    required this.radius,
    required this.deployedUnitClass,
    required this.isOpponentUnit,
    required this.hitPoint,
    this.kanjiMode = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (kanjiMode == true) {
      Paint circlePainter = Paint()
        ..color = Color(
          UnitSpec.unitSpec.firstWhere(
                (element) => element["unit_class"] == deployedUnitClass,
              )["color"] ??
              0xFF000000,
        );
      canvas.drawCircle(
        Offset(centerOffset.dx, centerOffset.dy),
        radius * 0.54,
        circlePainter,
      );
      Paint circleBorderPainter = Paint()
        ..color = Colors.black
        ..strokeWidth = radius * 0.083
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(
        Offset(centerOffset.dx, centerOffset.dy),
        radius * 0.54,
        circleBorderPainter,
      );
    }

    double arcAngle = 2 * math.pi * (hitPoint / 5);
    Paint hitPointPainter = Paint()
      ..color = Colors.greenAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.083;

    if (isOpponentUnit == true) {
      canvas.save();
      canvas.translate(
        centerOffset.dx * 2,
        centerOffset.dy * 2,
      );
      canvas.rotate(math.pi);
      canvas.drawArc(
        Rect.fromCircle(
          center: centerOffset,
          radius: radius * 0.45,
        ),
        -math.pi / 2,
        arcAngle,
        false,
        hitPointPainter,
      );

      canvas.restore();
    } else {
      canvas.drawArc(
        Rect.fromCircle(
          center: centerOffset,
          radius: radius * 0.45,
        ),
        -math.pi / 2,
        arcAngle,
        false,
        hitPointPainter,
      );
    }

    if (kanjiMode == true) {
      final span = TextSpan(
        style: TextStyle(
          fontSize: radius * 0.4,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "Yuji Syuku",
        ),
        text: UnitSpec.unitSpec.firstWhere(
          (element) => element["unit_class"] == deployedUnitClass,
        )["symbol"],
      );
      final textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();

      if (isOpponentUnit == true) {
        canvas.save();
        canvas.translate(
          centerOffset.dx + (textPainter.width / 2),
          centerOffset.dy + (textPainter.height / 2),
        );
        canvas.rotate(math.pi);

        textPainter.paint(
          canvas,
          const Offset(
            0,
            0,
          ),
        );

        canvas.restore();
      } else {
        textPainter.paint(
          canvas,
          Offset(
            centerOffset.dx - (textPainter.width / 2),
            centerOffset.dy - (textPainter.height / 2),
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class UnitCoinContainer extends StatelessWidget {
  final String unitClass;
  final double size;
  final bool shouldHide;
  final bool isSelected;
  final bool? isKanjiMode;

  const UnitCoinContainer({
    Key? key,
    required this.unitClass,
    required this.size,
    required this.shouldHide,
    required this.isSelected,
    this.isKanjiMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: shouldHide == true
                ? Colors.grey
                : isSelected == true
                    ? Colors.greenAccent
                    : Color(
                        UnitSpec.unitSpec.firstWhere(
                              (element) => element["unit_class"] == unitClass,
                            )["color"] ??
                            0xFF000000,
                      ),
            border: isKanjiMode != null
                ? isKanjiMode == true
                    ? Border.all(
                        color: Colors.black,
                        width: size * 0.084,
                      )
                    : null
                : globalKanjiMode
                    ? Border.all(
                        color: Colors.black,
                        width: size * 0.084,
                      )
                    : null,
          ),
          child: isKanjiMode != null
              ? isKanjiMode == true
                  ? Center(
                      child: Text(
                        shouldHide == true
                            ? ""
                            : UnitSpec.unitSpec.firstWhere(
                                  (element) => element["unit_class"] == unitClass,
                                )["symbol"] ??
                                "",
                        style: TextStyle(
                          fontSize: size * 0.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Visibility(
                          visible: unitClass != UnitClassConst.none,
                          child: Image.asset(
                            "assets/units/$unitClass.png",
                          ),
                        ),
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: shouldHide == true
                                ? Colors.grey
                                : isSelected == true
                                    ? Colors.greenAccent.withOpacity(0.3)
                                    : null,
                            border: shouldHide == true
                                ? Border.all(
                                    color: const Color(0xFF76757e),
                                    width: size * 0.084,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    )
              : globalKanjiMode
                  ? Center(
                      child: Text(
                        shouldHide == true
                            ? ""
                            : UnitSpec.unitSpec.firstWhere(
                                  (element) => element["unit_class"] == unitClass,
                                )["symbol"] ??
                                "",
                        style: TextStyle(
                          fontSize: size * 0.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        Visibility(
                          visible: unitClass != UnitClassConst.none,
                          child: Image.asset(
                            "assets/units/$unitClass.png",
                          ),
                        ),
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: shouldHide == true
                                ? Colors.grey
                                : isSelected == true
                                    ? Colors.greenAccent.withOpacity(0.3)
                                    : null,
                            border: shouldHide == true
                                ? Border.all(
                                    color: const Color(0xFF76757e),
                                    width: size * 0.084,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
        ),
      ],
    );
  }
}
