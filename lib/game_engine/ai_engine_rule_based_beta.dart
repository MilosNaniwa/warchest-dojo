import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/game_engine/minimax_dart.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';

class AiEngineRuleBasedAiBeta {
  static const String priorityConst = "priority";
  static const String actionConst = "action";

  static ActionModel choiceSpecificAction({
    required List<ActionModel> actions,
    required GameStateModel gameState,
    required String actionType,
    required String unitClass,
  }) {
    final selectedAction = () {
      if (actionType == ActionTypeConst.move) {
        return _computeAiMovingArea(
          gameState: gameState,
          actions: actions,
          actionType: ActionTypeConst.move,
          vitalArea: [],
        );
      }

      if (actionType == ActionTypeConst.instructionMove) {
        return _computeAiMovingArea(
          gameState: gameState,
          actions: actions,
          actionType: ActionTypeConst.instructionMove,
          vitalArea: [],
        );
      }

      if (actionType == ActionTypeConst.recruit) {
        return _computeAiRecruitAlgorithm(
          actions: actions,
          gameState: gameState,
        );
      }

      actions.shuffle();

      return actions.firstWhere(
        (element) => element.unitToUse.unitClass == unitClass && element.actionType == actionType,
      );
    }();

    return selectedAction;
  }

  static ActionModel choiceAction({
    required List<ActionModel> actions,
    required GameStateModel gameState,
  }) {
    return MiniMaxCalculation.findBestMove(
      gameState,
      actions.first.team,
    );
  }

  static ActionModel _computeAiMovingArea({
    required List<ActionModel> actions,
    required String actionType,
    required GameStateModel gameState,
    required List<String> vitalArea,
  }) {
    // 敵ユニットを探索
    final List enemyUnits = gameState.unitsState
        .where(
          (element) => element.team != gameState.turn && element.layer == HexagonConst.board,
        )
        .map(
          (e) => e.location,
        )
        .toSet()
        .toList();

    // 盤上の自陣営以外の拠点を全てリストアップ
    final List controlPoints = gameState.controlPointsState
        .where(
          (element) => element.dominatedBy != gameState.turn,
        )
        .map(
          (e) => e.tileId,
        )
        .toSet()
        .toList();

    // 自陣営のユニットがいる場所を候補から排除
    controlPoints.removeWhere(
      (element) => gameState.unitsState
          .where(
            (element) => element.team == gameState.turn && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .contains(element),
    );

    final movableUnits = actions
        .where(
          (element) => element.actionType == actionType,
        )
        .map(
          (e) => e.unitsToAction.first,
        )
        .toList();

    final targetList = movableUnits.map(
      (movableUnit) {
        final List targetArea = () {
          if ([
                // UnitClassConst.cavalry,
              ].contains(movableUnit.unitClass) &&
              enemyUnits.isNotEmpty) {
            return enemyUnits;
          }

          if ([
                UnitClassConst.archer,
              ].contains(movableUnit.unitClass) &&
              enemyUnits.isNotEmpty) {
            final tmp = controlPoints;
            tmp.removeWhere(
              (element) => enemyUnits.contains(element),
            );
            tmp.add("3–2");
            return tmp;
          }

          return (enemyUnits + controlPoints).toSet().toList();
        }();

        // 行動するユニットから最も近い目標を算出
        targetArea.sort(
          (a, b) {
            final distanceA = Emulator.emulateDistance(
              currentTile: movableUnit.location,
              targetTile: a,
            );
            final distanceB = Emulator.emulateDistance(
              currentTile: movableUnit.location,
              targetTile: b,
            );

            if (distanceA < distanceB) {
              return -1;
            }

            if (distanceA > distanceB) {
              return 1;
            }

            if (gameState.unitsState
                .where(
                  (element) => element.location == a,
                )
                .isNotEmpty) {
              if (gameState.unitsState
                  .where(
                    (element) => element.location == b,
                  )
                  .isNotEmpty) {
                return 0;
              } else {
                return 1;
              }
            }

            if (gameState.unitsState
                .where(
                  (element) => element.location == b,
                )
                .isNotEmpty) {
              return -1;
            }

            return 0;
          },
        );

        if (Emulator.emulateDistance(
              currentTile: movableUnit.location,
              targetTile: targetArea.first,
            ) >
            3) {
          targetArea.insert(0, "3–3");
        }

        return {
          "location": movableUnit.location,
          "target": targetArea.first,
          "distance": Emulator.emulateDistance(
            currentTile: movableUnit.location,
            targetTile: targetArea.first,
          ),
        };
      },
    ).toList();

    targetList.sort(
      (a, b) {
        if (a["distance"] < b["distance"]) {
          return -1;
        }

        if (a["distance"] > b["distance"]) {
          return 1;
        }

        return 0;
      },
    );

    final movingActions = actions
        .where(
          (element) =>
              element.actionType == actionType &&
              element.unitsToAction.first.location == targetList.first["location"],
        )
        .toList();

    if (movingActions
        .where(
          (element) =>
              vitalArea.contains(
                element.targetLocation,
              ) ==
              false,
        )
        .isNotEmpty) {
      movingActions.removeWhere(
        (element) =>
            vitalArea.contains(
              element.targetLocation,
            ) &&
            element.unitsToAction.first.unitClass != UnitClassConst.knight &&
            element.unitsToAction.length < 2,
      );
    }

    // 移動可能範囲のうち、最も目標に近づけるタイルを算出
    movingActions.sort(
      (a, b) {
        final distanceA = Emulator.emulateDistance(
          currentTile: targetList.first["target"],
          targetTile: a.targetLocation,
        );
        final distanceB = Emulator.emulateDistance(
          currentTile: targetList.first["target"],
          targetTile: b.targetLocation,
        );

        if (distanceA < distanceB) {
          return -1;
        }

        if (distanceA > distanceB) {
          return 1;
        }

        return 0;
      },
    );

    final selected = () {
      if ([
        UnitClassConst.archer,
        UnitClassConst.lancer,
      ].contains(
        movingActions.first.unitsToAction.first.unitClass,
      )) {
        if ([
          UnitClassConst.archer,
        ].contains(
          movingActions.first.unitsToAction.first.unitClass,
        )) {
          if (gameState.controlPointsState
                  .where(
                    (element) => element.dominatedBy == gameState.turn,
                  )
                  .length <
              6) {
            return movingActions.first;
          }
        }

        if ([
          UnitClassConst.lancer,
        ].contains(
          movingActions.first.unitsToAction.first.unitClass,
        )) {
          if (gameState.controlPointsState
                  .where(
                    (element) => element.dominatedBy == gameState.turn,
                  )
                  .length <
              6) {
            return movingActions.first;
          }
        }

        targetList.removeWhere(
          (element) =>
              gameState.unitsState
                  .where(
                    (element) =>
                        element.team != gameState.turn && element.layer == HexagonConst.board,
                  )
                  .map(
                    (e) => e.location,
                  )
                  .toList()
                  .contains(
                    element["target"],
                  ) ==
              false,
        );

        if (targetList.isEmpty) {
          return movingActions.first;
        }

        return movingActions.firstWhere(
          (element) {
            final distance = Emulator.emulateDistance(
              currentTile: element.unitsToAction.first.location,
              targetTile: targetList.first["target"],
            );

            return distance >= 2;
          },
          orElse: () => movingActions.first,
        );
      }

      return movingActions.first;
    }();

    return selected;
  }

  static ActionModel _computeAiRecruitAlgorithm({
    required List<ActionModel> actions,
    required GameStateModel gameState,
  }) {
    final supply = gameState.unitsState
        .where(
          (element) => element.team == gameState.turn && element.layer == HexagonConst.supply,
        )
        .toList();

    supply.sort(
      (a, b) {
        final countA = gameState.unitsState
            .where(
              (element) => element.layer == HexagonConst.supply && element.unitClass == a.unitClass,
            )
            .length;
        final countB = gameState.unitsState
            .where(
              (element) => element.layer == HexagonConst.supply && element.unitClass == b.unitClass,
            )
            .length;

        if (countA < countB) {
          return 1;
        }

        if (countA > countB) {
          return -1;
        }

        final countC = gameState.unitsState
            .where(
              (element) =>
                  [
                    HexagonConst.hand,
                    HexagonConst.bag,
                    HexagonConst.discard,
                  ].contains(
                    element.layer,
                  ) &&
                  element.unitClass == a.unitClass,
            )
            .length;
        final countD = gameState.unitsState
            .where(
              (element) =>
                  [
                    HexagonConst.hand,
                    HexagonConst.bag,
                    HexagonConst.discard,
                  ].contains(
                    element.layer,
                  ) &&
                  element.unitClass == b.unitClass,
            )
            .length;

        if (countC < countD) {
          return -1;
        }

        if (countC > countD) {
          return 1;
        }

        return 0;
      },
    );

    return actions.firstWhere(
      (element) => element.unitsToAction.first.unitClass == supply.first.unitClass,
    );
  }
}
