import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/model/control_point_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class Emulator {
  static List<String> emulateSingleAdjacentTile({
    required String location,
  }) {
    final coordinateX = int.parse(
      location.split("–")[0],
    );
    final coordinateY = int.parse(
      location.split("–")[1],
    );
    final isOddCoordinateX = coordinateX % 2 == 1;
    final point1 = "$coordinateX–${coordinateY - 1}";
    final point2 = isOddCoordinateX
        ? "${coordinateX + 1}–$coordinateY"
        : "${coordinateX + 1}–${coordinateY - 1}";
    final point3 = isOddCoordinateX
        ? "${coordinateX + 1}–${coordinateY + 1}"
        : "${coordinateX + 1}–$coordinateY";
    final point4 = "$coordinateX–${coordinateY + 1}";
    final point5 = isOddCoordinateX
        ? "${coordinateX - 1}–${coordinateY + 1}"
        : "${coordinateX - 1}–$coordinateY";
    final point6 = isOddCoordinateX
        ? "${coordinateX - 1}–$coordinateY"
        : "${coordinateX - 1}–${coordinateY - 1}";

    final tiles = [
      point1,
      point2,
      point3,
      point4,
      point5,
      point6,
    ];

    return tiles;
  }

  static List<String> emulateDoubleAdjacentTile({
    required String location,
  }) {
    // X軸が偶数か奇数かで計算が異なる
    final coordinateX = int.parse(
      location.split("–")[0],
    );
    final coordinateY = int.parse(
      location.split("–")[1],
    );
    final isOddCoordinateX = coordinateX % 2 == 1;
    final point1 = "$coordinateX–${coordinateY - 2}";
    final point2 = isOddCoordinateX
        ? "${coordinateX + 1}–${coordinateY - 1}"
        : "${coordinateX + 1}–${coordinateY - 2}";
    final point3 = isOddCoordinateX
        ? "${coordinateX + 2}–${coordinateY - 1}"
        : "${coordinateX + 2}–${coordinateY - 1}";
    final point4 = "${coordinateX + 2}–$coordinateY";
    final point5 = isOddCoordinateX
        ? "${coordinateX + 2}–${coordinateY + 1}"
        : "${coordinateX + 2}–${coordinateY + 1}";
    final point6 = isOddCoordinateX
        ? "${coordinateX + 1}–${coordinateY + 2}"
        : "${coordinateX + 1}–${coordinateY + 1}";
    final point7 = "$coordinateX–${coordinateY + 2}";
    final point8 = isOddCoordinateX
        ? "${coordinateX - 1}–${coordinateY + 2}"
        : "${coordinateX - 1}–${coordinateY + 1}";
    final point9 = isOddCoordinateX
        ? "${coordinateX - 2}–${coordinateY + 1}"
        : "${coordinateX - 2}–${coordinateY + 1}";
    final point10 = "${coordinateX - 2}–$coordinateY";
    final point11 = isOddCoordinateX
        ? "${coordinateX - 2}–${coordinateY - 1}"
        : "${coordinateX - 2}–${coordinateY - 1}";
    final point12 = isOddCoordinateX
        ? "${coordinateX - 1}–${coordinateY - 1}"
        : "${coordinateX - 1}–${coordinateY - 2}";

    final tiles = [
      point1,
      point2,
      point3,
      point4,
      point5,
      point6,
      point7,
      point8,
      point9,
      point10,
      point11,
      point12,
    ];

    return tiles;
  }

  static List<String> emulateTripleAdjacentTile({
    required String location,
  }) {
    // X軸が偶数か奇数かで計算が異なる
    final coordinateX = int.parse(
      location.split("–")[0],
    );
    final coordinateY = int.parse(
      location.split("–")[1],
    );
    final isOddCoordinateX = coordinateX % 2 == 1;
    final point1 = "$coordinateX–${coordinateY - 3}";
    final point2 = isOddCoordinateX
        ? "${coordinateX + 1}–${coordinateY - 2}"
        : "${coordinateX + 1}–${coordinateY - 3}";
    final point3 = isOddCoordinateX
        ? "${coordinateX + 2}–${coordinateY - 2}"
        : "${coordinateX + 2}–${coordinateY - 2}";
    final point4 = isOddCoordinateX
        ? "${coordinateX + 3}–${coordinateY - 1}"
        : "${coordinateX + 3}–${coordinateY - 2}";
    final point5 = isOddCoordinateX
        ? "${coordinateX + 3}–$coordinateY"
        : "${coordinateX + 3}–${coordinateY - 1}";
    final point6 = isOddCoordinateX
        ? "${coordinateX + 3}–${coordinateY + 1}"
        : "${coordinateX + 3}–$coordinateY";
    final point7 = isOddCoordinateX
        ? "${coordinateX + 3}–${coordinateY + 2}"
        : "${coordinateX + 3}–${coordinateY + 1}";
    final point8 = isOddCoordinateX
        ? "${coordinateX + 2}–${coordinateY + 2}"
        : "${coordinateX + 2}–${coordinateY + 2}";
    final point9 = isOddCoordinateX
        ? "${coordinateX + 1}–${coordinateY + 3}"
        : "${coordinateX + 1}–${coordinateY + 2}";
    final point10 = "$coordinateX–${coordinateY + 3}";
    final point11 = isOddCoordinateX
        ? "${coordinateX - 1}–${coordinateY + 3}"
        : "${coordinateX - 1}–${coordinateY + 2}";
    final point12 = isOddCoordinateX
        ? "${coordinateX - 2}–${coordinateY + 2}"
        : "${coordinateX - 2}–${coordinateY + 2}";
    final point13 = isOddCoordinateX
        ? "${coordinateX - 3}–${coordinateY + 2}"
        : "${coordinateX - 3}–${coordinateY + 1}";
    final point14 = isOddCoordinateX
        ? "${coordinateX - 3}–${coordinateY + 1}"
        : "${coordinateX - 3}–$coordinateY";
    final point15 = isOddCoordinateX
        ? "${coordinateX - 3}–$coordinateY"
        : "${coordinateX - 3}–${coordinateY - 1}";
    final point16 = isOddCoordinateX
        ? "${coordinateX - 3}–${coordinateY - 1}"
        : "${coordinateX - 3}–${coordinateY - 2}";
    final point17 = isOddCoordinateX
        ? "${coordinateX - 2}–${coordinateY - 2}"
        : "${coordinateX - 2}–${coordinateY - 2}";
    final point18 = isOddCoordinateX
        ? "${coordinateX - 1}–${coordinateY - 2}"
        : "${coordinateX - 1}–${coordinateY - 3}";

    final tiles = [
      point1,
      point2,
      point3,
      point4,
      point5,
      point6,
      point7,
      point8,
      point9,
      point10,
      point11,
      point12,
      point13,
      point14,
      point15,
      point16,
      point17,
      point18,
    ];

    return tiles;
  }

  static String emulateForegroundTileOfTarget({
    required currentTileId,
    required targetTileId,
  }) {
    final currentCoordinateX = int.parse(
      currentTileId.split("–")[0],
    );
    final currentCoordinateY = int.parse(
      currentTileId.split("–")[1],
    );
    final targetCoordinateX = int.parse(
      targetTileId.split("–")[0],
    );
    final targetCoordinateY = int.parse(
      targetTileId.split("–")[1],
    );

    final computedCoordinateX = () {
      if (currentCoordinateX < targetCoordinateX) {
        return targetCoordinateX - 1;
      } else if (currentCoordinateX > targetCoordinateX) {
        return targetCoordinateX + 1;
      } else {
        return targetCoordinateX;
      }
    }();

    final computedCoordinateY = () {
      final isOddComputedX = computedCoordinateX % 2 == 1;
      if (computedCoordinateX == currentCoordinateX) {
        return currentCoordinateY < targetCoordinateY
            ? targetCoordinateY - 1
            : targetCoordinateY + 1;
      } else if (currentCoordinateY < targetCoordinateY) {
        return isOddComputedX == true ? targetCoordinateY - 1 : targetCoordinateY;
      } else if (currentCoordinateY > targetCoordinateY) {
        return isOddComputedX == true ? targetCoordinateY : targetCoordinateY + 1;
      }
    }();

    return "$computedCoordinateX–$computedCoordinateY";
  }

  static int emulateDistance({
    required String currentTile,
    required String targetTile,
  }) {
    if (currentTile == targetTile) {
      return 0;
    }

    if (emulateSingleAdjacentTile(
      location: currentTile,
    ).contains(targetTile)) {
      return 1;
    }

    if (emulateDoubleAdjacentTile(
      location: currentTile,
    ).contains(targetTile)) {
      return 2;
    }

    if (emulateTripleAdjacentTile(
      location: currentTile,
    ).contains(targetTile)) {
      return 3;
    }

    return 4;
  }

  static List<String> emulateAttackableArea({
    required String unitClass,
    required String currentLocation,
    required String team,
    required bool isBolstered,
    required List<UnitModel> unitsState,
    bool simulateMode = false,
  }) {
    final List<String> targetArea = () {
      // 弓兵の場合は２マス先を攻撃範囲とする
      if (unitClass == UnitClassConst.archer) {
        return emulateDoubleAdjacentTile(
          location: currentLocation,
        );
      }

      // 騎兵の場合かつシミュレーションモードの場合、２マス以内は全て攻撃対象
      else if (unitClass == UnitClassConst.cavalry && simulateMode == true) {
        final singleAdjacentArea = emulateSingleAdjacentTile(
          location: currentLocation,
        );
        final doubleAdjacentArea = emulateDoubleAdjacentTile(
          location: currentLocation,
        );
        return singleAdjacentArea + doubleAdjacentArea;
      }

      // 弩兵の場合は直線上の２マス先と隣接マスを攻撃範囲とする
      else if (unitClass == UnitClassConst.crossbow) {
        final singleAdjacentArea = emulateSingleAdjacentTile(
          location: currentLocation,
        );
        final doubleAdjacentArea = emulateDoubleAdjacentTile(
          location: currentLocation,
        );
        final crossbowManTarget = <String>[
          for (int index = 0; index < doubleAdjacentArea.length; index++)
            if (index % 2 == 0) doubleAdjacentArea[index],
        ];
        for (int index = 0; index < singleAdjacentArea.length; index++) {
          final isAttackable = unitsState
              .where(
                (element) => element.location == singleAdjacentArea[index],
              )
              .isEmpty;

          if (isAttackable == false) {
            crossbowManTarget[index] = "remove";
          }
        }
        crossbowManTarget.removeWhere(
          (element) => element == "remove",
        );

        return singleAdjacentArea + crossbowManTarget;
      }

      // 突撃騎兵の場合は隣接マス以外の直線上３マス先までを攻撃範囲とする
      else if (unitClass == UnitClassConst.lancer) {
        final singleAdjacentArea = emulateSingleAdjacentTile(
          location: currentLocation,
        );
        final doubleAdjacentArea = emulateDoubleAdjacentTile(
          location: currentLocation,
        );
        final doubleAdjacentTarget = <String>[
          for (int index = 0; index < doubleAdjacentArea.length; index++)
            if (index % 2 == 0) doubleAdjacentArea[index],
        ];
        final tripleAdjacentArea = emulateTripleAdjacentTile(
          location: currentLocation,
        );
        final tripleAdjacentTarget = <String>[
          for (int index = 0; index < tripleAdjacentArea.length; index++)
            if (index % 3 == 0) tripleAdjacentArea[index],
        ];

        // 間にユニットがいる場合は２マス先を攻撃範囲から除外
        for (int index = 0; index < singleAdjacentArea.length; index++) {
          final isAttackable = unitsState
              .where(
                (element) => element.location == singleAdjacentArea[index],
              )
              .isEmpty;

          if (isAttackable == false) {
            doubleAdjacentTarget[index] = "remove";
            tripleAdjacentTarget[index] = "remove";
          }
        }
        doubleAdjacentTarget.removeWhere(
          (element) => element == "remove",
        );
        tripleAdjacentTarget.removeWhere(
          (element) => element == "remove",
        );

        // 間にユニットがいる場合は３マス先を攻撃範囲から除外
        for (int index = 0; index < doubleAdjacentTarget.length; index++) {
          final isAttackable = unitsState
              .where(
                (element) => element.location == doubleAdjacentTarget[index],
              )
              .isEmpty;

          if (isAttackable == false) {
            tripleAdjacentTarget[index] = "remove";
          }
        }
        tripleAdjacentTarget.removeWhere(
          (element) => element == "remove",
        );

        return doubleAdjacentTarget + tripleAdjacentTarget;
      }

      // 通常ユニットの場合は隣接のみ攻撃範囲とする
      else {
        return emulateSingleAdjacentTile(
          location: currentLocation,
        );
      }
    }();

    // 敵ユニットがいる地点を抽出する
    final attackableArea = simulateMode
        ? targetArea
        : targetArea
            .where(
              (target) => unitsState
                  .where(
                    (opponent) => opponent.location == target && opponent.team != team,
                  )
                  .isNotEmpty,
            )
            .toList();

    attackableArea.removeWhere(
      (element) =>
          HexagonConst.availableTile.contains(
            element,
          ) ==
          false,
    );

    // 敵ユニットが重装兵の場合、自ユニットが強化されている場合のみ攻撃可能
    attackableArea.removeWhere(
      (target) => unitsState
          .where(
            (opponent) =>
                opponent.location == target &&
                opponent.unitClass == UnitClassConst.knight &&
                isBolstered == false,
          )
          .isNotEmpty,
    );

    return attackableArea;
  }

  static List<String> emulateDominatableArea({
    required String currentLocation,
    required String team,
    required List<ControlPointModel> controlPointsState,
  }) {
    final opponentTeam =
        team == HexagonConst.playerBlue ? HexagonConst.playerRed : HexagonConst.playerBlue;

    final dominatable = controlPointsState
        .where(
          (controlPoint) =>
              controlPoint.tileId == currentLocation &&
              (controlPoint.dominatedBy == HexagonConst.neutral ||
                  controlPoint.dominatedBy == opponentTeam),
        )
        .map(
          (controlPoint) => controlPoint.tileId,
        )
        .toList();

    return dominatable;
  }

  static List<String> emulateBolsterableArea({
    required String currentLocation,
    required List<UnitModel> unitsState,
  }) {
    final bolsterableList = unitsState
        .where(
          (unit) => unit.location == currentLocation,
        )
        .map(
          (unit) => unit.location,
        )
        .toList();

    return bolsterableList;
  }

  static List<String> emulateMovableArea({
    required String unitClass,
    required String currentLocation,
    required List<UnitModel> unitsState,
    required bool isNeededToComputeByInstruction,
  }) {
    final adjacentTileList = emulateSingleAdjacentTile(
      location: currentLocation,
    );

    final movableArea = adjacentTileList
        .where(
          (targetTile) => unitsState
              .where(
                (unit) => unit.location == targetTile,
              )
              .isEmpty,
        )
        .toList();

    // 軽騎兵の場合
    if (isNeededToComputeByInstruction == false && unitClass == UnitClassConst.lightCavalry) {
      final List<String> lightCavalryMovableArea = [];
      for (final targetTile in movableArea) {
        final adjacentTileList = emulateSingleAdjacentTile(
          location: targetTile,
        );

        lightCavalryMovableArea.addAll(
          adjacentTileList.where(
            (targetTile) => unitsState
                .where(
                  (unit) => unit.location == targetTile,
                )
                .isEmpty,
          ),
        );
      }

      lightCavalryMovableArea.addAll(movableArea);

      lightCavalryMovableArea.removeWhere(
        (element) =>
            HexagonConst.availableTile.contains(
              element,
            ) ==
            false,
      );

      return lightCavalryMovableArea.toSet().toList();
    }

    // 指示による移動の場合、旗兵の周囲２マスまでのみに範囲を制限する
    if (isNeededToComputeByInstruction == true) {
      final ensignLocation = unitsState
          .firstWhere(
            (element) =>
                element.unitClass == UnitClassConst.ensign && element.layer == HexagonConst.board,
          )
          .location;

      final adjacentAreaOfEnsign = emulateSingleAdjacentTile(
            location: ensignLocation,
          ) +
          emulateDoubleAdjacentTile(
            location: ensignLocation,
          );

      movableArea.removeWhere(
        (element) => adjacentAreaOfEnsign.contains(element) == false,
      );
    }

    movableArea.removeWhere(
      (element) =>
          HexagonConst.availableTile.contains(
            element,
          ) ==
          false,
    );

    return movableArea;
  }

  static List<String> emulateDeployableArea({
    required String team,
    required String unitClass,
    required List<ControlPointModel> controlPointsState,
    required List<UnitModel> unitState,
  }) {
    final List<String> deployableArea = [];

    // 偵察兵の場合、味方ユニットの隣接エリアを展開可能範囲とする
    if (unitClass == UnitClassConst.scout) {
      for (final element in unitState) {
        if (element.team == team && element.layer == HexagonConst.board) {
          final singleAdjacentArea = emulateSingleAdjacentTile(
            location: element.location,
          );
          deployableArea.addAll(
            singleAdjacentArea,
          );
        }
      }
    }

    // 展開のアクション
    deployableArea.addAll(
      controlPointsState
          .where(
            // 自陣営の占領地点を抽出する
            (controlPoint) => controlPoint.dominatedBy == team,
          )
          .map(
            // タイルIDのみ抽出する
            (e) => e.tileId,
          )
          .toList(),
    );

    deployableArea.removeWhere(
      // ユニット未配置の地点を抽出する
      (tileId) => unitState
          .where(
            (unit) => unit.location == tileId,
          )
          .isNotEmpty,
    );

    deployableArea.removeWhere(
      (element) => HexagonConst.availableTile.contains(element) == false,
    );

    return deployableArea;
  }

  static List<String> emulateInstuctableArea({
    required String unitClass,
    required String currentLocation,
    required String team,
    required List<UnitModel> unitState,
  }) {
    final singleAdjacentTileList = emulateSingleAdjacentTile(
      location: currentLocation,
    );
    final doubleAdjacentTileList = emulateDoubleAdjacentTile(
      location: currentLocation,
    );

    final totalArea = singleAdjacentTileList + doubleAdjacentTileList;

    final instructableArea = totalArea
        .where(
          (targetTile) => unitState
              .where(
                (unit) => unit.location == targetTile && unit.team == team,
              )
              .isNotEmpty,
        )
        .toList();

    if (unitClass == UnitClassConst.marshall) {
      instructableArea.removeWhere(
        (tileId) {
          final instructedUnit = unitState
              .where(
                (unit) => unit.location == tileId,
              )
              .toList();
          // 弓兵と突撃騎兵は除外
          if ([
            UnitClassConst.lancer,
            UnitClassConst.archer,
          ].contains(
            instructedUnit.first.unitClass,
          )) {
            return true;
          }

          // 周囲に攻撃対象がいないユニットは除外
          else if (emulateAttackableArea(
            unitClass: instructedUnit.first.unitClass,
            currentLocation: instructedUnit.first.location,
            team: instructedUnit.first.team,
            isBolstered: instructedUnit.length > 1,
            unitsState: unitState,
          ).isEmpty) {
            return true;
          }

          // 攻撃可能
          else {
            return false;
          }
        },
      );
    }

    return instructableArea;
  }
}
