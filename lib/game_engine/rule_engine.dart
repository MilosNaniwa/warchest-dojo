import 'dart:math' as math;

import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/tactic_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/const/unit_spec.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/game_engine/executor.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/play_page_message.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/control_point_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class RuleEngine {
  static const _emptyUnit = UnitModel(
    unitId: UnitClassConst.none,
    unitClass: UnitClassConst.none,
    team: HexagonConst.neutral,
    location: HexagonConst.none,
    layer: UnitClassConst.none,
    shouldHide: false,
  );

  static GameStateModel initializeGame({
    required List<String> unitClassListOfBlue,
    required List<String> unitClassListOfRed,
    required String initiative,
    String difficulty = HexagonConst.sergeant,
    int seed = 3148,
  }) {
    final List<UnitModel> unitsState = [];

    for (final unitClass in unitClassListOfBlue) {
      final unitData = UnitSpec.unitSpec.firstWhere(
        (element) => element["unit_class"] == unitClass,
      );

      for (int i = 0; i < unitData["quantity"]; i++) {
        unitsState.add(
          UnitModel(
            unitId: "$unitClass–${i + 1}",
            unitClass: unitClass,
            team: HexagonConst.playerBlue,
            location: i < 2 ? HexagonConst.bag : HexagonConst.supply,
            layer: i < 2 ? HexagonConst.bag : HexagonConst.supply,
            shouldHide: false,
          ),
        );
      }
    }

    for (final unitClass in unitClassListOfRed) {
      final unitData = UnitSpec.unitSpec.firstWhere(
        (element) => element["unit_class"] == unitClass,
      );
      for (int i = 0; i < unitData["quantity"]; i++) {
        unitsState.add(
          UnitModel(
            unitId: "$unitClass–${i + 1}",
            unitClass: unitClass,
            team: HexagonConst.playerRed,
            location: i < 2 ? HexagonConst.bag : HexagonConst.supply,
            layer: i < 2 ? HexagonConst.bag : HexagonConst.supply,
            shouldHide: false,
          ),
        );
      }
    }

    final List<ControlPointModel> controlPointsState = [
      const ControlPointModel(
        tileId: "0–4",
        dominatedBy: HexagonConst.neutral,
      ),
      ControlPointModel(
        tileId: "1–2",
        dominatedBy: [
          HexagonConst.shogun,
          HexagonConst.prototype,
        ].contains(difficulty)
            ? HexagonConst.playerRed
            : HexagonConst.neutral,
      ),
      const ControlPointModel(
        tileId: "1–5",
        dominatedBy: HexagonConst.playerBlue,
      ),
      const ControlPointModel(
        tileId: "2–1",
        dominatedBy: HexagonConst.playerRed,
      ),
      const ControlPointModel(
        tileId: "2–4",
        dominatedBy: HexagonConst.neutral,
      ),
      const ControlPointModel(
        tileId: "4–3",
        dominatedBy: HexagonConst.neutral,
      ),
      const ControlPointModel(
        tileId: "4–6",
        dominatedBy: HexagonConst.playerBlue,
      ),
      ControlPointModel(
        tileId: "5–1",
        dominatedBy:
            difficulty == HexagonConst.chief ? HexagonConst.neutral : HexagonConst.playerRed,
      ),
      const ControlPointModel(
        tileId: "5–4",
        dominatedBy: HexagonConst.neutral,
      ),
      const ControlPointModel(
        tileId: "6–3",
        dominatedBy: HexagonConst.neutral,
      ),
    ];

    final afterHandDraw = _drawHands(
      seed: seed,
      gameState: GameStateModel(
        snapshotId: 0,
        turn: initiative,
        initiative: initiative,
        hasChangedInitiative: false,
        unitClassesOfBlue: unitClassListOfBlue,
        unitClassesOfRed: unitClassListOfRed,
        controlPointsState: controlPointsState,
        unitsState: unitsState,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        textLog: PlayPageMessage.of(globalLanguageCode).gameStarted,
        waitingFootmanLocations: const [],
        lastAction: ActionModel(
          team: HexagonConst.neutral,
          actionType: ActionTypeConst.none,
          unitsToAction: const [],
          targetLocation: HexagonConst.none,
          unitToUse: _emptyUnit.copyWith(),
        ),
        allowedActionTypes: const [],
        winner: '',
        hasGameFinished: false,
        winningType: "",
      ),
    );

    return afterHandDraw;
  }

  static GameStateModel _drawHands({
    required GameStateModel gameState,
    required int seed,
  }) {
    for (String currentTeam in [
      HexagonConst.playerBlue,
      HexagonConst.playerRed,
    ]) {
      for (int count = 0; count < 2; count++) {
        // 手札が３枚揃っていれば次のループへ
        if (gameState.unitsState
                .where(
                  (element) => element.team == currentTeam && element.layer == HexagonConst.hand,
                )
                .length ==
            3) {
          continue;
        }

        final remainderOfBag = gameState.unitsState
            .where(
              (element) => element.team == currentTeam && element.location == HexagonConst.bag,
            )
            .toList();

        final bag = remainderOfBag.isNotEmpty
            ? remainderOfBag
            : gameState.unitsState
                .where(
                  (element) =>
                      element.team == currentTeam && element.location == HexagonConst.discard,
                )
                .toList();

        for (final unitModel in bag) {
          gameState.unitsState.removeWhere(
            (element) => element.unitId == unitModel.unitId,
          );
          gameState.unitsState.add(
            unitModel.copyWith(
              location: HexagonConst.bag,
              layer: HexagonConst.bag,
            ),
          );
        }

        final initialHandCount = gameState.unitsState
            .where(
              (element) => element.team == currentTeam && element.layer == HexagonConst.hand,
            )
            .length;

        bag.shuffle(math.Random(seed));

        for (; bag.length > (3 - initialHandCount);) {
          final index = math.Random(seed).nextInt(bag.length);
          bag.removeAt(index);
        }

        for (int i = 0; i < bag.length; i++) {
          // バッグから手札へ
          gameState.unitsState.removeWhere(
            (element) => element.unitId == bag[i].unitId,
          );
          gameState.unitsState.add(
            bag[i].copyWith(
              location: "${HexagonConst.hand}${i + 1 + initialHandCount}",
              layer: HexagonConst.hand,
            ),
          );
        }
      }
    }

    return gameState.copyWith(
      allowedActionTypes: [
        ActionTypeConst.deploy,
        ActionTypeConst.move,
        ActionTypeConst.attack,
        ActionTypeConst.dominate,
        ActionTypeConst.bolster,
        ActionTypeConst.recruit,
        ActionTypeConst.takeInitiative,
        ActionTypeConst.instructionMove,
        ActionTypeConst.instructionAttack,
      ],
    );
  }

  static List<ActionModel> listUpActions({
    required UnitModel unitToUse,
    required GameStateModel gameState,
  }) {
    final List<ActionModel> actions = [];

    final unitsToAction = gameState.unitsState
        .where(
          (element) =>
              element.unitClass == unitToUse.unitClass && element.layer == HexagonConst.board,
        )
        .toList();

    if (unitsToAction.isEmpty) {
      unitsToAction.add(
        _emptyUnit.copyWith(),
      );
    }

    // パス
    actions.add(
      ActionModel(
        team: unitToUse.team,
        actionType: ActionTypeConst.pass,
        unitsToAction: [
          _emptyUnit.copyWith(),
        ],
        targetLocation: HexagonConst.none,
        unitToUse: unitToUse,
      ),
    );

    if (gameState.allowedActionTypes.contains(
          ActionTypeConst.takeInitiative,
        ) &&
        gameState.hasChangedInitiative == false &&
        gameState.initiative != gameState.turn) {
      // 先攻奪取
      actions.add(
        ActionModel(
          team: unitToUse.team,
          actionType: ActionTypeConst.takeInitiative,
          unitsToAction: [
            _emptyUnit.copyWith(),
          ],
          targetLocation: HexagonConst.none,
          unitToUse: unitToUse,
        ),
      );
    }

    // 雇用可能な選択肢を探索
    if (gameState.allowedActionTypes.contains(
      ActionTypeConst.recruit,
    )) {
      for (final unitClass in gameState.turn == HexagonConst.playerBlue
          ? gameState.unitClassesOfBlue
          : gameState.unitClassesOfRed) {
        final candidate = gameState.unitsState.firstWhere(
          (element) => element.unitClass == unitClass && element.layer == HexagonConst.supply,
          orElse: () => _emptyUnit.copyWith(),
        );

        if (candidate.unitId != UnitClassConst.none) {
          // 雇用
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.recruit,
              unitsToAction: [
                candidate,
              ],
              targetLocation: HexagonConst.none,
              unitToUse: unitToUse,
            ),
          );
        }
      }
    }

    if ([
      UnitClassConst.blueRoyal,
      UnitClassConst.redRoyal,
    ].contains(
      unitToUse.unitClass,
    )) {
      return actions;
    }

    // 展開可能な選択肢を探索
    if (gameState.allowedActionTypes.contains(
          ActionTypeConst.deploy,
        ) &&
        unitsToAction.first.unitClass == UnitClassConst.none) {
      final deployable = Emulator.emulateDeployableArea(
        unitClass: unitToUse.unitClass,
        team: unitToUse.team,
        unitState: gameState.unitsState,
        controlPointsState: gameState.controlPointsState,
      );

      for (final location in deployable) {
        // 展開
        actions.add(
          ActionModel(
            team: unitToUse.team,
            actionType: ActionTypeConst.deploy,
            unitsToAction: [
              _emptyUnit.copyWith(),
            ],
            targetLocation: location,
            unitToUse: unitToUse,
          ),
        );
      }
    }

    // 従兵の場合、多重展開可能な選択肢を探索
    if (gameState.allowedActionTypes.contains(
          ActionTypeConst.deploy,
        ) &&
        unitsToAction.first.unitClass == UnitClassConst.footman &&
        gameState.waitingFootmanLocations.length < 2) {
      final deployable = Emulator.emulateDeployableArea(
        unitClass: unitToUse.unitClass,
        team: unitToUse.team,
        unitState: gameState.unitsState,
        controlPointsState: gameState.controlPointsState,
      );

      for (final location in deployable) {
        // 展開
        actions.add(
          ActionModel(
            team: unitToUse.team,
            actionType: ActionTypeConst.deploy,
            unitsToAction: [
              _emptyUnit.copyWith(),
            ],
            targetLocation: location,
            unitToUse: unitToUse,
          ),
        );
      }
    }

    final unitsLocationList = unitsToAction
        .map(
          (e) => e.location,
        )
        .toSet()
        .toList();

    // 従兵の場合、動作待ちの駒がいる地点のみに絞り込む
    if (unitsToAction.first.unitClass == UnitClassConst.footman) {
      unitsLocationList.removeWhere(
        (element) => gameState.waitingFootmanLocations.contains(element) == false,
      );
    }

    for (final unitLocation in unitsLocationList) {
      // 占領可能な選択肢を探索
      if (gameState.allowedActionTypes.contains(
            ActionTypeConst.dominate,
          ) &&
          unitsToAction.first.unitClass != UnitClassConst.none) {
        final dominatable = Emulator.emulateDominatableArea(
          team: unitsToAction.first.team,
          currentLocation: unitLocation,
          controlPointsState: gameState.controlPointsState,
        );

        for (final location in dominatable) {
          // 占領
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.dominate,
              unitsToAction: unitsToAction
                  .where(
                    (element) => element.location == unitLocation,
                  )
                  .toList(),
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }

      // 攻撃可能な選択肢を探索
      if (gameState.allowedActionTypes.contains(
            ActionTypeConst.attack,
          ) &&
          unitsToAction.first.unitClass != UnitClassConst.none) {
        final attackable = Emulator.emulateAttackableArea(
          unitClass: unitsToAction.first.unitClass,
          team: unitsToAction.first.team,
          isBolstered: unitsToAction
                  .where(
                    (element) => element.location == unitLocation,
                  )
                  .toList()
                  .length >
              1,
          unitsState: gameState.unitsState,
          currentLocation: unitLocation,
        );

        for (final location in attackable) {
          // 攻撃
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.attack,
              unitsToAction: unitsToAction
                  .where(
                    (element) => element.location == unitLocation,
                  )
                  .toList(),
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }

      // 強化可能な選択肢を探索
      if (gameState.allowedActionTypes.contains(
            ActionTypeConst.bolster,
          ) &&
          unitsToAction.first.unitClass != UnitClassConst.none) {
        final bolsterable = Emulator.emulateBolsterableArea(
          currentLocation: unitLocation,
          unitsState: gameState.unitsState,
        );

        for (final location in bolsterable) {
          // 強化
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.bolster,
              unitsToAction: [
                _emptyUnit.copyWith(),
              ],
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }

      // 移動可能な選択肢を探索
      if (gameState.allowedActionTypes.contains(
            ActionTypeConst.move,
          ) &&
          unitsToAction.first.unitClass != UnitClassConst.none) {
        final movable = Emulator.emulateMovableArea(
          unitClass: unitToUse.unitClass,
          unitsState: gameState.unitsState,
          currentLocation: unitsToAction
              .where(
                (element) => element.location == unitLocation,
              )
              .toList()
              .first
              .location,
          isNeededToComputeByInstruction: false,
        );

        for (final location in movable) {
          // 移動
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.move,
              unitsToAction: unitsToAction
                  .where(
                    (element) => element.location == unitLocation,
                  )
                  .toList(),
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }
    }

    // 移動支援可能な選択肢を探索
    if (gameState.allowedActionTypes.contains(
          ActionTypeConst.instructionMove,
        ) &&
        unitsToAction.first.unitClass == UnitClassConst.ensign) {
      final instructable = Emulator.emulateInstuctableArea(
        unitClass: unitsToAction.first.unitClass,
        currentLocation: unitsToAction.first.location,
        team: unitsToAction.first.team,
        unitState: gameState.unitsState,
      );

      for (final instructableLocation in instructable) {
        final instructedUnits = gameState.unitsState
            .where(
              (element) => element.location == instructableLocation,
            )
            .toList();

        final movable = Emulator.emulateMovableArea(
          unitClass: instructedUnits.first.unitClass,
          unitsState: gameState.unitsState,
          currentLocation: instructedUnits.first.location,
          isNeededToComputeByInstruction: true,
        );

        for (final location in movable) {
          // 支援移動
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.instructionMove,
              unitsToAction: instructedUnits,
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }
    }

    // 攻撃支援可能な選択肢を探索
    if (gameState.allowedActionTypes.contains(
          ActionTypeConst.instructionAttack,
        ) &&
        unitsToAction.first.unitClass == UnitClassConst.marshall) {
      final instructable = Emulator.emulateInstuctableArea(
        unitClass: unitsToAction.first.unitClass,
        currentLocation: unitsToAction.first.location,
        team: unitsToAction.first.team,
        unitState: gameState.unitsState,
      );

      for (final instructableLocation in instructable) {
        final instructedUnits = gameState.unitsState
            .where(
              (element) => element.location == instructableLocation,
            )
            .toList();

        final attackable = Emulator.emulateAttackableArea(
          unitClass: instructedUnits.first.unitClass,
          team: instructedUnits.first.team,
          isBolstered: instructedUnits.length > 1,
          unitsState: gameState.unitsState,
          currentLocation: instructedUnits.first.location,
        );

        for (final location in attackable) {
          // 支援攻撃
          actions.add(
            ActionModel(
              team: unitToUse.team,
              actionType: ActionTypeConst.instructionAttack,
              unitsToAction: instructedUnits,
              targetLocation: location,
              unitToUse: unitToUse,
            ),
          );
        }
      }
    }

    return actions;
  }

  static List<ActionModel> listUpAllActions({
    required GameStateModel gameState,
  }) {
    if (gameState.allowedActionTypes.any(
      (element) => [
        TacticConst.endurance,
        TacticConst.berserk,
        TacticConst.oracle,
        TacticConst.haste,
        TacticConst.immediateForce,
        TacticConst.teamwork,
      ].contains(element),
    )) {
      return listUpTacticAction(
        gameState: gameState,
      );
    }

    final hands = gameState.unitsState
        .where(
          (element) => element.team == gameState.turn && element.layer == HexagonConst.hand,
        )
        .toList();

    final List<ActionModel> actions = [];

    for (final unit in hands) {
      actions.addAll(
        listUpActions(
          unitToUse: unit,
          gameState: gameState,
        ),
      );
    }

    return actions;
  }

  static GameStateModel executeAction({
    required ActionModel action,
    required GameStateModel gameState,
  }) {
    final afterActionGameState = () {
      switch (action.actionType) {
        case ActionTypeConst.move:
          return Executor.executeMoving(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.bolster:
          return Executor.executeBolstering(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.deploy:
          return Executor.executeDeploying(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.recruit:
          return Executor.executeRecruiting(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.dominate:
          return Executor.executeDominating(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.pass:
          return Executor.executePassing(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.takeInitiative:
          return Executor.executeTakingInitiative(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.attack:
          return Executor.executeAttacking(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.instructionMove:
          return Executor.executeMoving(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        case ActionTypeConst.instructionAttack:
          return Executor.executeAttacking(
            actionModel: action,
            gameState: gameState.copyWith(),
          );
        default:
          print("例外のアクション");
          throw Error();
      }
    }();

    final winner = () {
      // 青の制圧勝利
      if (afterActionGameState.controlPointsState
              .where(
                (element) => element.dominatedBy == HexagonConst.playerBlue,
              )
              .length >
          5) {
        return [
          HexagonConst.playerBlue,
          HexagonConst.dominated,
        ];
      }

      // 赤の制圧勝利
      else if (afterActionGameState.controlPointsState
              .where(
                (element) => element.dominatedBy == HexagonConst.playerRed,
              )
              .length >
          5) {
        return [
          HexagonConst.playerRed,
          HexagonConst.dominated,
        ];
      }
      // 青の殲滅勝利
      else if (afterActionGameState.unitsState
              .where(
                (element) =>
                    element.team == HexagonConst.playerRed &&
                    [
                      HexagonConst.bag,
                      HexagonConst.hand,
                      HexagonConst.supply,
                      HexagonConst.discard,
                    ].contains(
                      element.layer,
                    ),
              )
              .length <
          2) {
        return [
          HexagonConst.playerBlue,
          HexagonConst.eliminated,
        ];
      }

      // 赤の殲滅勝利
      else if (afterActionGameState.unitsState
              .where(
                (element) =>
                    element.team == HexagonConst.playerBlue &&
                    [
                      HexagonConst.bag,
                      HexagonConst.hand,
                      HexagonConst.supply,
                      HexagonConst.discard,
                    ].contains(
                      element.layer,
                    ),
              )
              .length <
          2) {
        return [
          HexagonConst.playerRed,
          HexagonConst.eliminated,
        ];
      } else {
        return [];
      }
    }();

    return afterActionGameState.copyWith(
      snapshotId: afterActionGameState.snapshotId + 1,
      hasGameFinished: winner.isNotEmpty == true,
      winner: winner.isNotEmpty ? winner[0] : "",
      winningType: winner.isNotEmpty ? winner[1] : "",
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  static List<ActionModel> listUpTacticAction({
    required GameStateModel gameState,
  }) {
    if (gameState.allowedActionTypes.isNotEmpty) {
      switch (gameState.lastAction.unitsToAction.first.unitClass) {
        case UnitClassConst.sword:
          return listUpActions(
            unitToUse: gameState.lastAction.unitsToAction.first,
            gameState: gameState.copyWith(),
          );
        case UnitClassConst.mercenary:
          return listUpActions(
            unitToUse: gameState.lastAction.unitsToAction.first,
            gameState: gameState.copyWith(),
          );
        case UnitClassConst.cavalry:
          return listUpActions(
            unitToUse: gameState.lastAction.unitsToAction.first,
            gameState: gameState.copyWith(),
          );
        case UnitClassConst.berserker:
          return listUpActions(
            unitToUse: gameState.lastAction.unitsToAction.first,
            gameState: gameState.copyWith(),
          );
        case UnitClassConst.warriorPriest:
          return listUpActions(
            unitToUse: gameState.unitsState.firstWhere(
              (element) => element.location == "${HexagonConst.hand}4",
            ),
            gameState: gameState.copyWith(),
          );
        case UnitClassConst.footman:
          if (gameState.waitingFootmanLocations.length == 1) {
            return listUpActions(
              unitToUse: gameState.lastAction.unitsToAction.first,
              gameState: gameState.copyWith(),
            );
          } else {
            return [];
          }
        default:
          return [];
      }
    }

    return [];
  }

  static GameStateModel forwardToNextState({
    required GameStateModel gameState,
    int seed = 3148,
  }) {
    if (gameState.allowedActionTypes.any(
      (element) => [
        TacticConst.endurance,
        TacticConst.berserk,
        TacticConst.oracle,
        TacticConst.haste,
        TacticConst.immediateForce,
        TacticConst.teamwork,
      ].contains(element),
    )) {
      return gameState;
    }

    final opponentTurn = gameState.turn == HexagonConst.playerBlue
        ? HexagonConst.playerRed
        : HexagonConst.playerBlue;

    final GameStateModel nextTurnGameState = () {
          if (gameState.unitsState
                  .where(
                    (element) => element.team == opponentTurn && element.layer == HexagonConst.hand,
                  )
                  .isNotEmpty ==
              true) {
            return gameState.copyWith(
              turn: opponentTurn,
            );
          }

          if (gameState.unitsState
                  .where(
                    (element) => element.layer == HexagonConst.hand,
                  )
                  .isEmpty ==
              true) {
            final afterDrawGameState = _drawHands(
              gameState: gameState.copyWith(),
              seed: seed,
            );

            return afterDrawGameState.copyWith(
              turn: gameState.initiative,
              hasChangedInitiative: false,
            );
          }
        }() ??
        gameState.copyWith();

    return nextTurnGameState.copyWith(
      allowedActionTypes: [
        ActionTypeConst.deploy,
        ActionTypeConst.move,
        ActionTypeConst.attack,
        ActionTypeConst.dominate,
        ActionTypeConst.bolster,
        ActionTypeConst.recruit,
        ActionTypeConst.takeInitiative,
        ActionTypeConst.instructionMove,
        ActionTypeConst.instructionAttack,
      ],
      waitingFootmanLocations: nextTurnGameState.unitsState
          .where(
            (element) =>
                element.unitClass == UnitClassConst.footman && element.layer == HexagonConst.board,
          )
          .map(
            (e) => e.location,
          )
          .toSet()
          .toList(),
    );
  }
}
