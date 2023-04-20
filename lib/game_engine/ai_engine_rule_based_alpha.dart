import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class AiEngineRuleBasedAiAlpha {
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
    // 敵の攻撃確率エリアを算出する
    final opponentOnBoardingUnits = gameState.unitsState
        .where(
          (element) => element.layer == HexagonConst.board && element.team != gameState.turn,
        )
        .toList();

    final List<String> vitalArea = opponentOnBoardingUnits
        .map(
          (opponentUnit) => _calculatePossibilityToAttack(opponentUnit, gameState),
        )
        .where(
          (element) => element.isNotEmpty,
        )
        .expand(
          (element) => element,
        )
        .toSet()
        .toList();

    actions.shuffle();

    final priorityList = actions
        .map(
          (ActionModel currentAction) => _assignPriorityToAction(currentAction, gameState),
        )
        .toList();

    priorityList.sort((a, b) => (b[priorityConst] as int).compareTo(a[priorityConst] as int));

    final topAction = priorityList.first[actionConst] as ActionModel;

    final selectedAction = _selectBestAction(topAction, actions, gameState, vitalArea);

    return selectedAction;
  }

  static List<String> _calculatePossibilityToAttack(
      UnitModel opponentUnit, GameStateModel gameState) {
    final possibilityToAttack = () {
      final availableCoin = gameState.unitsState
          .where(
            (element) =>
                element.unitClass == opponentUnit.unitClass &&
                [
                  HexagonConst.hand,
                  HexagonConst.bag,
                  HexagonConst.discard,
                ].contains(element.layer),
          )
          .length;
      final discardedCoin = gameState.unitsState
          .where(
            (element) =>
                element.unitClass == opponentUnit.unitClass &&
                [
                  HexagonConst.discard,
                ].contains(element.layer) &&
                element.shouldHide == false,
          )
          .length;
      int possibleCoin = availableCoin - discardedCoin;
      if (possibleCoin < 1) {
        return 0.0;
      }

      final bagCoin = gameState.unitsState
          .where(
            (element) =>
                element.team == opponentUnit.team &&
                [
                  HexagonConst.bag,
                ].contains(element.layer),
          )
          .length;

      final handCoin = gameState.unitsState
          .where(
            (element) =>
                element.team == opponentUnit.team &&
                [
                  HexagonConst.hand,
                ].contains(element.layer),
          )
          .length;

      int bagAndHandCoin = bagCoin + handCoin;

      if (bagCoin == 0 && [1, 2, 3].contains(handCoin) && possibleCoin > 0) {
        return 1.0;
      }

      if (handCoin == 0 && bagCoin < 3) {
        bagAndHandCoin = bagCoin +
            gameState.unitsState
                .where(
                  (element) =>
                      element.team == opponentUnit.team &&
                      [
                        HexagonConst.discard,
                      ].contains(element.layer),
                )
                .length;
        possibleCoin = availableCoin;
      }

      final totalPattern = () {
        int patternA = 1;
        for (int i = bagAndHandCoin; i > (bagAndHandCoin - 3); i--) {
          patternA = i * patternA;
        }
        int patternB = 1;
        for (int i = 3; i > 0; i--) {
          patternB = i * patternB;
        }
        return patternA / patternB;
      }()
          .toInt();

      final exceptionPattern = () {
        final exceptionCoin = bagAndHandCoin - possibleCoin;
        if (exceptionCoin < 3) {
          return 1;
        }
        int patternA = 1;
        for (int i = exceptionCoin; i > (exceptionCoin - 3); i--) {
          patternA = i * patternA;
        }
        int patternB = 1;
        for (int i = 3; i > 0; i--) {
          patternB = i * patternB;
        }
        return patternA / patternB;
      }()
          .toInt();

      if (totalPattern - exceptionPattern < 1) {
        return 0.0;
      }

      final possibility = (totalPattern - exceptionPattern) / totalPattern;

      return possibility;
    }();

    if (possibilityToAttack >= 0.9) {
      return Emulator.emulateAttackableArea(
        unitClass: opponentUnit.unitClass,
        currentLocation: opponentUnit.location,
        team: opponentUnit.team,
        isBolstered: gameState.unitsState
                .where(
                  (element) => element.location == opponentUnit.location,
                )
                .length >
            1,
        unitsState: gameState.unitsState,
        simulateMode: true,
      );
    } else {
      return [""];
    }
  }

  static Map<String, dynamic> _assignPriorityToAction(
      ActionModel currentAction, GameStateModel gameState) {
    final priority = () {
      switch (currentAction.actionType) {
        case ActionTypeConst.dominate:
          return 10;
        case ActionTypeConst.attack:
          final targetUnit = gameState.unitsState.firstWhere(
            (element) => element.location == currentAction.targetLocation,
          );

          if (targetUnit.unitClass == UnitClassConst.pike &&
              currentAction.unitsToAction.length < 2) {
            if (Emulator.emulateSingleAdjacentTile(
              location: currentAction.unitsToAction.first.location,
            ).contains(
              targetUnit.location,
            )) {
              return 4;
            }
          }
          return 9;
        case ActionTypeConst.instructionAttack:
          final targetUnit = gameState.unitsState.firstWhere(
            (element) => element.location == currentAction.targetLocation,
          );

          if (targetUnit.unitClass == UnitClassConst.pike &&
              currentAction.unitsToAction.length < 2) {
            return 4;
          }
          return 9;
        case ActionTypeConst.deploy:
          return 7;
        case ActionTypeConst.instructionMove:
          if (gameState.controlPointsState
              .where(
                (element) => element.dominatedBy == HexagonConst.neutral,
              )
              .map(
                (e) => e.tileId,
              )
              .contains(
                currentAction.unitsToAction.first.location,
              )) {
            return 0;
          }
          return 6;
        case ActionTypeConst.move:
          if (gameState.controlPointsState
              .where(
                (element) => element.dominatedBy == HexagonConst.neutral,
              )
              .map(
                (e) => e.tileId,
              )
              .contains(
                currentAction.unitsToAction.first.location,
              )) {
            return 0;
          }

          return 6;
        case ActionTypeConst.bolster:
          // 突撃兵の場合、強化は避ける
          if (currentAction.unitToUse.unitClass == UnitClassConst.lancer) {
            return 1;
          }

          // 周囲に敵の重装兵がいる場合
          final isNeighborOfKnight = Emulator.emulateSingleAdjacentTile(
            location: currentAction.targetLocation,
          )
              .where(
                (adjacentTile) => gameState.unitsState
                    .where(
                      (unit) =>
                          unit.team != gameState.turn &&
                          unit.location == adjacentTile &&
                          [
                            UnitClassConst.knight,
                          ].contains(
                            unit.unitClass,
                          ),
                    )
                    .isNotEmpty,
              )
              .isNotEmpty;

          if (isNeighborOfKnight) {
            return 8;
          }

          final condition = currentAction.unitToUse.unitClass == UnitClassConst.berserker ? 0 : 3;

          if (gameState.unitsState
                  .where(
                    (element) =>
                        element.unitClass == currentAction.unitToUse.unitClass &&
                        [
                          HexagonConst.bag,
                          HexagonConst.hand,
                          HexagonConst.discard,
                        ].contains(
                          element.layer,
                        ),
                  )
                  .length >
              condition) {
            return 6;
          }

          return 5;
        case ActionTypeConst.takeInitiative:
          return 3;
        case ActionTypeConst.recruit:
          return 2;
        default:
          return 1;
      }
    }();

    return {
      priorityConst: priority,
      actionConst: currentAction,
    };
  }

  static ActionModel _selectBestAction(ActionModel topAction, List<ActionModel> actions,
      GameStateModel gameState, List<String> vitalArea) {
    if (topAction.actionType == ActionTypeConst.move) {
      return _computeAiMovingArea(
        gameState: gameState,
        actions: actions,
        actionType: ActionTypeConst.move,
        vitalArea: vitalArea,
      );
    }

    if (topAction.actionType == ActionTypeConst.instructionMove) {
      return _computeAiMovingArea(
        gameState: gameState,
        actions: actions,
        actionType: ActionTypeConst.instructionMove,
        vitalArea: vitalArea,
      );
    }

    if (topAction.actionType == ActionTypeConst.recruit) {
      return _computeAiRecruitAlgorithm(
        actions: actions,
        gameState: gameState,
      );
    }

    if (topAction.actionType == ActionTypeConst.deploy) {
      return _computeAiDeployingArea(
        actions: actions,
        gameState: gameState,
        vitalArea: vitalArea,
      );
    }

    return topAction;
  }

  static ActionModel _computeAiDeployingArea({
    required List<ActionModel> actions,
    required GameStateModel gameState,
    required List<String> vitalArea,
  }) {
    final allTargetArea = [];

    // 盤上の自陣営以外の拠点を全てリストアップ
    allTargetArea.addAll(
      gameState.controlPointsState
          .where(
            (element) => element.dominatedBy != gameState.turn,
          )
          .map(
            (e) => e.tileId,
          )
          .toList(),
    );

    // 自陣営のユニットがいる場所を候補から排除
    allTargetArea.removeWhere(
      (element) => gameState.unitsState
          .where(
            (element) => element.team == gameState.turn && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .contains(element),
    );

    allTargetArea.addAll(
      gameState.unitsState
          .where(
            (element) => element.team != gameState.turn && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .toList(),
    );

    // 重複を排除
    final targetArea = allTargetArea.toSet().toList();

    final deployableLocation = actions
        .where(
          (element) => element.actionType == ActionTypeConst.deploy,
        )
        .map(
          (e) => e.targetLocation,
        )
        .toSet()
        .toList();

    final targetList = deployableLocation.map(
      (location) {
        // 行動するユニットから最も近い目標を算出
        targetArea.sort(
          (a, b) {
            final distanceA = Emulator.emulateDistance(
              currentTile: location,
              targetTile: a,
            );
            final distanceB = Emulator.emulateDistance(
              currentTile: location,
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
              currentTile: location,
              targetTile: targetArea.first,
            ) >
            3) {
          targetArea.insert(0, "3–3");
        }

        return {
          "location": location,
          "target": targetArea.first,
          "distance": Emulator.emulateDistance(
            currentTile: location,
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

    final deployingActions = actions
        .where(
          (element) =>
              element.actionType == ActionTypeConst.deploy &&
              element.targetLocation == targetList.first["location"],
        )
        .toList();

    if (deployingActions
        .where(
          (element) =>
              vitalArea.contains(
                element.targetLocation,
              ) ==
              false,
        )
        .isNotEmpty) {
      deployingActions.removeWhere(
        (element) =>
            vitalArea.contains(
              element.targetLocation,
            ) &&
            [
              UnitClassConst.pike,
              UnitClassConst.knight,
            ].contains(element.unitsToAction.first.unitClass),
      );
    }

    // 展開可能範囲のうち、最も目標に近づけるタイルを算出
    deployingActions.sort(
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

    return deployingActions.first;
  }

  static ActionModel _computeAiMovingArea({
    required List<ActionModel> actions,
    required String actionType,
    required GameStateModel gameState,
    required List<String> vitalArea,
  }) {
    final allTargetArea = [];

    // 盤上の自陣営以外の拠点を全てリストアップ
    allTargetArea.addAll(
      gameState.controlPointsState
          .where(
            (element) => element.dominatedBy != gameState.turn,
          )
          .map(
            (e) => e.tileId,
          )
          .toList(),
    );

    // 自陣営のユニットがいる場所を候補から排除
    allTargetArea.removeWhere(
      (element) => gameState.unitsState
          .where(
            (element) => element.team == gameState.turn && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .contains(element),
    );

    allTargetArea.addAll(
      gameState.unitsState
          .where(
            (element) => element.team != gameState.turn && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .toList(),
    );

    // 重複を排除
    final targetArea = allTargetArea.toSet().toList();

    final movableUnitsLocation = actions
        .where(
          (element) => element.actionType == actionType,
        )
        .map(
          (e) => e.unitsToAction.first.location,
        )
        .toSet()
        .toList();

    final targetList = movableUnitsLocation.map(
      (movableUnitLocation) {
        // 行動するユニットから最も近い目標を算出
        targetArea.sort(
          (a, b) {
            final distanceA = Emulator.emulateDistance(
              currentTile: movableUnitLocation,
              targetTile: a,
            );
            final distanceB = Emulator.emulateDistance(
              currentTile: movableUnitLocation,
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
              currentTile: movableUnitLocation,
              targetTile: targetArea.first,
            ) >
            3) {
          targetArea.insert(0, "3–3");
        }

        return {
          "location": movableUnitLocation,
          "target": targetArea.first,
          "distance": Emulator.emulateDistance(
            currentTile: movableUnitLocation,
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

    return movingActions.first;
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
