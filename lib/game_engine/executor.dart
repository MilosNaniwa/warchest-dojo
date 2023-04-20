import 'dart:math';

import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/tactic_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/play_page_message.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/control_point_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/util/util.dart';

class Executor {
  static GameStateModel executeDeploying({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    if (actionModel.unitToUse.unitClass == UnitClassConst.footman) {
      final deployable = gameState.unitsState
          .where(
            (element) =>
                element.unitClass == UnitClassConst.footman && element.layer == HexagonConst.supply,
          )
          .toList();

      if (deployable.isNotEmpty) {
        // サプライから盤上へ
        gameState.unitsState.removeWhere(
          (element) => element.unitId == deployable.first.unitId,
        );
        gameState.unitsState.add(
          deployable.first.copyWith(
            location: actionModel.targetLocation,
            layer: HexagonConst.board,
          ),
        );

        // 手札から捨て場へ
        gameState.unitsState.removeWhere(
          (element) => element.unitId == actionModel.unitToUse.unitId,
        );
        gameState.unitsState.add(
          actionModel.unitToUse.copyWith(
            location: HexagonConst.discard,
            layer: HexagonConst.discard,
          ),
        );

        return gameState.copyWith(
          lastAction: actionModel.copyWith(),
          allowedActionTypes: [],
          waitingFootmanLocations: [],
          textLog: PlayPageMessage.of(globalLanguageCode)
              .unitWasDeployed
              .replaceAll(
                "{team}",
                Util.convertTeamIdToTeamName(
                  team: gameState.turn,
                ),
              )
              .replaceAll(
                "{unit}",
                Util.convertUnitClassToUnitName(
                  unitClass: actionModel.unitToUse.unitClass,
                ),
              )
              .replaceAll(
                "{location}",
                Util.convertTileIdToTileName(
                  tileId: actionModel.targetLocation,
                ),
              ),
        );
      }
    }

    gameState.unitsState.removeWhere(
      (element) => element.unitId == actionModel.unitToUse.unitId,
    );
    gameState.unitsState.add(
      actionModel.unitToUse.copyWith(
        location: actionModel.targetLocation,
        layer: HexagonConst.board,
      ),
    );

    return gameState.copyWith(
      lastAction: actionModel.copyWith(),
      allowedActionTypes: [],
      waitingFootmanLocations: [],
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasDeployed
          .replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          )
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitToUse.unitClass,
            ),
          )
          .replaceAll(
            "{location}",
            Util.convertTileIdToTileName(
              tileId: actionModel.targetLocation,
            ),
          ),
    );
  }

  static GameStateModel executeBolstering({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    gameState.unitsState.removeWhere(
      (element) => element.unitId == actionModel.unitToUse.unitId,
    );
    gameState.unitsState.add(
      actionModel.unitToUse.copyWith(
        location: actionModel.targetLocation,
        layer: HexagonConst.board,
      ),
    );

    return gameState.copyWith(
      lastAction: actionModel.copyWith(),
      allowedActionTypes: [],
      waitingFootmanLocations: [],
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasBolstered
          .replaceAll(
              "{team}",
              Util.convertTeamIdToTeamName(
                team: gameState.turn,
              ))
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitToUse.unitClass,
            ),
          ),
    );
  }

  static GameStateModel executeAttacking({
    required ActionModel actionModel,
    required GameStateModel gameState,
    int seed = 3148,
  }) {
    if (gameState.allowedActionTypes.any(
          (element) => [
            TacticConst.berserk,
            TacticConst.endurance,
            TacticConst.haste,
            TacticConst.teamwork,
          ].contains(element),
        ) ==
        false) {
      // 手札から捨て場へ
      gameState.unitsState.removeWhere(
        (element) => element.unitId == actionModel.unitToUse.unitId,
      );
      gameState.unitsState.add(
        actionModel.unitToUse.copyWith(
          location: HexagonConst.discard,
          layer: HexagonConst.discard,
        ),
      );
    }

    final targetUnitList = gameState.unitsState
        .where(
          (element) => element.location == actionModel.targetLocation,
        )
        .toList();

    final defeatedUnitList = () {
      // 攻撃目標が衛兵ならば、雇用場から排除する
      if (targetUnitList.first.unitClass == UnitClassConst.royalGuard) {
        final supplyOfRoyalGuard = gameState.unitsState
            .where(
              (element) =>
                  element.unitClass == UnitClassConst.royalGuard &&
                  element.layer == HexagonConst.supply,
            )
            .toList();

        if (supplyOfRoyalGuard.isNotEmpty) {
          if (actionModel.unitsToAction.first.unitClass == UnitClassConst.lancer) {
            if (supplyOfRoyalGuard.length > 1) {
              return [
                supplyOfRoyalGuard[0],
                supplyOfRoyalGuard[1],
              ];
            }

            if (supplyOfRoyalGuard.length == 1) {
              return [
                supplyOfRoyalGuard[0],
                targetUnitList.first,
              ];
            }
          }

          return [
            supplyOfRoyalGuard.first.copyWith(),
          ];
        }
      }

      if (actionModel.unitsToAction.first.unitClass == UnitClassConst.lancer) {
        if (targetUnitList.length > 1) {
          return [
            targetUnitList[0],
            targetUnitList[1],
          ];
        }
      }

      return [
        targetUnitList.first.copyWith(),
      ];
    }();

    for (final defeatedUnit in defeatedUnitList) {
      // 盤上から墓場へ
      gameState.unitsState.removeWhere(
        (element) => element.unitId == defeatedUnit.unitId,
      );
      gameState.unitsState.add(
        defeatedUnit.copyWith(
          location: HexagonConst.cemetery,
          layer: HexagonConst.cemetery,
        ),
      );
    }

    // 突撃騎兵の場合、攻撃後に移動する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.lancer) {
      final foregroundTileOfTarget = Emulator.emulateForegroundTileOfTarget(
        currentTileId: actionModel.unitsToAction.first.location,
        targetTileId: actionModel.targetLocation,
      );

      // ユニットを移動
      for (final movingUnit in actionModel.unitsToAction) {
        gameState.unitsState.removeWhere(
          (element) => element.unitId == movingUnit.unitId,
        );
        gameState.unitsState.add(
          movingUnit.copyWith(
            location: foregroundTileOfTarget,
            layer: HexagonConst.board,
          ),
        );
      }
    }

    // 狂戦士の場合、自身の戦術利用による攻撃であれば強化を１枚剥ぐ
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      if (gameState.allowedActionTypes.contains(
        TacticConst.berserk,
      )) {
        // 盤上から捨て場へ
        gameState.unitsState.removeWhere(
          (element) => element.unitId == actionModel.unitsToAction.first.unitId,
        );
        gameState.unitsState.add(
          actionModel.unitsToAction.first.copyWith(
            location: HexagonConst.discard,
            layer: HexagonConst.discard,
          ),
        );
      }
    }

    // 攻撃されたユニットが槍兵かつ攻撃者が隣接している場合、攻撃者も墓場へ送る
    if (targetUnitList.first.unitClass == UnitClassConst.pike) {
      final singleAdjacentArea = Emulator.emulateSingleAdjacentTile(
        location: actionModel.targetLocation,
      );

      final attacker = gameState.unitsState
          .where(
            (element) => actionModel.unitsToAction
                .map(
                  (e) => e.unitId,
                )
                .toList()
                .contains(element.unitId),
          )
          .toList();

      if (singleAdjacentArea.contains(
            attacker.first.location,
          ) ==
          true) {
        gameState.unitsState.removeWhere(
          (element) => element.unitId == attacker.first.unitId,
        );
        gameState.unitsState.add(
          attacker.first.copyWith(
            location: HexagonConst.cemetery,
            layer: HexagonConst.cemetery,
          ),
        );
      }
    }

    final List<String> allowedActions = [];

    // 槍兵の反撃で消滅していないかチェックする
    final availableUnits = gameState.unitsState
        .where(
          (element) =>
              element.unitClass == actionModel.unitsToAction.first.unitClass &&
              element.layer == HexagonConst.board,
        )
        .toList();

    // 剣兵の場合、追加行動を設定する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.sword) {
      if (availableUnits.isNotEmpty) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            TacticConst.endurance,
          ],
        );
      }
    }

    // 僧兵の場合、攻撃後にコインを１枚ドローして即座に使用する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.warriorPriest) {
      gameState = drawExtraHand(
        gameState: gameState.copyWith(),
        seed: seed,
      );

      allowedActions.addAll(
        [
          ActionTypeConst.deploy,
          ActionTypeConst.move,
          ActionTypeConst.attack,
          ActionTypeConst.dominate,
          ActionTypeConst.bolster,
          ActionTypeConst.recruit,
          ActionTypeConst.takeInitiative,
          ActionTypeConst.instructionMove,
          ActionTypeConst.instructionAttack,
          TacticConst.oracle,
        ],
      );
    }

    // 狂戦士の場合、強化されていれば再行動を許可する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      if (availableUnits.length > 1) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.berserk,
          ],
        );
      }
    }

    // 従兵の場合、従兵配置場所から行動済みを取り除く
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.footman) {
      gameState.waitingFootmanLocations.removeWhere(
        (element) => element == actionModel.unitsToAction.first.location,
      );

      if (gameState.waitingFootmanLocations.length == 1 &&
          actionModel.actionType != ActionTypeConst.instructionAttack) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.teamwork,
          ],
        );
      }
    }

    return gameState.copyWith(
      allowedActionTypes: allowedActions,
      lastAction: actionModel.copyWith(),
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasAttacked
          .replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          )
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitsToAction.first.unitClass,
            ),
          )
          .replaceAll(
            "{target}",
            Util.convertUnitClassToUnitName(
              unitClass: targetUnitList.first.unitClass,
            ),
          ),
    );
  }

  static GameStateModel executeTakingInitiative({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    // 手札から捨て場へ
    gameState.unitsState.removeWhere(
      (element) => element.unitId == actionModel.unitToUse.unitId,
    );
    gameState.unitsState.add(
      actionModel.unitToUse.copyWith(
        location: HexagonConst.discard,
        layer: HexagonConst.discard,
        shouldHide: true,
      ),
    );

    return gameState.copyWith(
      initiative: actionModel.team,
      hasChangedInitiative: true,
      lastAction: actionModel.copyWith(),
      allowedActionTypes: [],
      waitingFootmanLocations: [],
      textLog: PlayPageMessage.of(globalLanguageCode).playerOrComputerHasTakenInitiative.replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          ),
    );
  }

  static GameStateModel executePassing({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    if (gameState.allowedActionTypes.any(
          (element) => [
            TacticConst.berserk,
            TacticConst.endurance,
            TacticConst.haste,
            TacticConst.teamwork,
          ].contains(element),
        ) ==
        false) {
      // 手札から捨て場へ
      gameState.unitsState.removeWhere(
        (element) => element.unitId == actionModel.unitToUse.unitId,
      );
      gameState.unitsState.add(
        actionModel.unitToUse.copyWith(
          location: HexagonConst.discard,
          layer: HexagonConst.discard,
          shouldHide: true,
        ),
      );
    }

    return gameState.copyWith(
      lastAction: actionModel.copyWith(),
      allowedActionTypes: [],
      waitingFootmanLocations: [],
      textLog: PlayPageMessage.of(globalLanguageCode).playerOrComputerPassed.replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          ),
    );
  }

  static GameStateModel executeDominating({
    required ActionModel actionModel,
    required GameStateModel gameState,
    int seed = 3148,
  }) {
    if (gameState.allowedActionTypes.any(
          (element) => [
            TacticConst.berserk,
            TacticConst.endurance,
            TacticConst.haste,
            TacticConst.teamwork,
          ].contains(element),
        ) ==
        false) {
      // 手札から捨て場へ
      gameState.unitsState.removeWhere(
        (element) => element.unitId == actionModel.unitToUse.unitId,
      );
      gameState.unitsState.add(
        actionModel.unitToUse.copyWith(
          location: HexagonConst.discard,
          layer: HexagonConst.discard,
        ),
      );
    }

    // 陣地を占領
    gameState.controlPointsState.removeWhere(
      (element) => element.tileId == actionModel.targetLocation,
    );
    gameState.controlPointsState.add(
      ControlPointModel(
        tileId: actionModel.targetLocation,
        dominatedBy: actionModel.team,
      ),
    );

    // 狂戦士の場合、戦術利用による行動であれば強化を１枚剥ぐ
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      // 戦術利用の場合
      if (gameState.allowedActionTypes.contains(
        TacticConst.berserk,
      )) {
        // 盤上から捨て場へ
        gameState.unitsState.removeWhere(
          (element) => element.unitId == actionModel.unitsToAction.first.unitId,
        );
        gameState.unitsState.add(
          actionModel.unitsToAction.first.copyWith(
            location: HexagonConst.discard,
            layer: HexagonConst.discard,
          ),
        );
      }
    }

    final List<String> allowedActions = [];

    // 剣兵の場合、追加行動を設定する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.sword) {
      allowedActions.addAll(
        [
          ActionTypeConst.move,
          TacticConst.endurance,
        ],
      );
    }

    // 僧兵の場合、攻撃後にコインを１枚ドローして即座に使用する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.warriorPriest) {
      gameState = drawExtraHand(
        gameState: gameState.copyWith(),
        seed: seed,
      );

      allowedActions.addAll(
        [
          ActionTypeConst.deploy,
          ActionTypeConst.move,
          ActionTypeConst.attack,
          ActionTypeConst.dominate,
          ActionTypeConst.bolster,
          ActionTypeConst.recruit,
          ActionTypeConst.takeInitiative,
          TacticConst.oracle,
          ActionTypeConst.instructionMove,
          ActionTypeConst.instructionAttack,
        ],
      );
    }

    // 狂戦士の場合、強化されていれば再行動を許可する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      final availableUnits = gameState.unitsState
          .where(
            (element) =>
                element.unitClass == actionModel.unitsToAction.first.unitClass &&
                element.layer == HexagonConst.board,
          )
          .toList();

      if (availableUnits.length > 1) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.berserk,
          ],
        );
      }
    }

    // 従兵の場合、従兵配置場所から行動済みを取り除く
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.footman) {
      gameState.waitingFootmanLocations.removeWhere(
        (element) => element == actionModel.unitsToAction.first.location,
      );

      if (gameState.waitingFootmanLocations.length == 1) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.teamwork,
          ],
        );
      }
    }

    return gameState.copyWith(
      lastAction: actionModel,
      allowedActionTypes: allowedActions,
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasDominated
          .replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          )
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitToUse.unitClass,
            ),
          )
          .replaceAll(
            "{location}",
            Util.convertTileIdToTileName(
              tileId: actionModel.targetLocation,
            ),
          ),
    );
  }

  static GameStateModel executeMoving({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    if (gameState.allowedActionTypes.any(
          (element) => [
            TacticConst.berserk,
            TacticConst.endurance,
            TacticConst.haste,
            TacticConst.teamwork,
          ].contains(element),
        ) ==
        false) {
      // 手札から捨て場へ
      gameState.unitsState.removeWhere(
        (element) => element.unitId == actionModel.unitToUse.unitId,
      );
      gameState.unitsState.add(
        actionModel.unitToUse.copyWith(
          location: HexagonConst.discard,
          layer: HexagonConst.discard,
        ),
      );
    }

    // ユニットを移動
    for (final movingUnit in actionModel.unitsToAction) {
      gameState.unitsState.removeWhere(
        (element) => element.unitId == movingUnit.unitId,
      );
      gameState.unitsState.add(
        movingUnit.copyWith(
          location: actionModel.targetLocation,
          layer: HexagonConst.board,
        ),
      );
    }

    // 狂戦士の場合、自身の戦術利用による攻撃であれば強化を１枚剥ぐ
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      if (gameState.allowedActionTypes.contains(
        TacticConst.berserk,
      )) {
        // 盤上から捨て場へ
        gameState.unitsState.removeWhere(
          (element) => element.unitId == actionModel.unitsToAction.first.unitId,
        );
        gameState.unitsState.add(
          actionModel.unitsToAction.first.copyWith(
            location: HexagonConst.discard,
            layer: HexagonConst.discard,
          ),
        );
      }
    }

    final List<String> allowedActions = [];

    // 騎兵の場合、移動後に攻撃を仕掛ける
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.cavalry) {
      final attackable = Emulator.emulateAttackableArea(
        unitClass: actionModel.unitsToAction.first.unitClass,
        currentLocation: actionModel.targetLocation,
        team: actionModel.team,
        isBolstered: actionModel.unitsToAction.length > 1,
        unitsState: gameState.unitsState,
      );

      if (attackable.isNotEmpty) {
        allowedActions.addAll(
          [
            ActionTypeConst.attack,
            TacticConst.haste,
          ],
        );
      }
    }

    // 狂戦士の場合、強化されていれば再行動を許可する
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.berserker) {
      final availableUnits = gameState.unitsState
          .where(
            (element) =>
                element.unitClass == actionModel.unitsToAction.first.unitClass &&
                element.layer == HexagonConst.board,
          )
          .toList();

      if (availableUnits.length > 1) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.berserk,
          ],
        );
      }
    }

    // 従兵の場合、従兵配置場所から行動済みを取り除く
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.footman) {
      gameState.waitingFootmanLocations.removeWhere(
        (element) => element == actionModel.unitsToAction.first.location,
      );

      if (gameState.waitingFootmanLocations.isNotEmpty &&
          actionModel.actionType != ActionTypeConst.instructionMove) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.teamwork,
          ],
        );
      }
    }

    return gameState.copyWith(
      lastAction: actionModel,
      allowedActionTypes: allowedActions,
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasMoved
          .replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          )
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitsToAction.first.unitClass,
            ),
          )
          .replaceAll(
            "{from}",
            Util.convertTileIdToTileName(
              tileId: actionModel.unitsToAction.first.location,
            ),
          )
          .replaceAll(
            "{to}",
            Util.convertTileIdToTileName(
              tileId: actionModel.targetLocation,
            ),
          ),
    );
  }

  static GameStateModel executeRecruiting({
    required ActionModel actionModel,
    required GameStateModel gameState,
  }) {
    // 手札から捨て場へ
    gameState.unitsState.removeWhere(
      (element) => element.unitId == actionModel.unitToUse.unitId,
    );
    gameState.unitsState.add(
      actionModel.unitToUse.copyWith(
        location: HexagonConst.discard,
        layer: HexagonConst.discard,
        shouldHide: true,
      ),
    );

    // サプライから捨て場へ
    gameState.unitsState.removeWhere(
      (element) => element.unitId == actionModel.unitsToAction.first.unitId,
    );
    gameState.unitsState.add(
      actionModel.unitsToAction.first.copyWith(
        location: HexagonConst.discard,
        layer: HexagonConst.discard,
      ),
    );

    final List<String> allowedActions = [];

    // 傭兵を徴兵した場合
    if (actionModel.unitsToAction.first.unitClass == UnitClassConst.mercenary) {
      final onBoardMercenaries = gameState.unitsState.where(
        (element) =>
            element.unitClass == UnitClassConst.mercenary && element.layer == HexagonConst.board,
      );

      if (onBoardMercenaries.isNotEmpty) {
        allowedActions.addAll(
          [
            ActionTypeConst.move,
            ActionTypeConst.attack,
            ActionTypeConst.dominate,
            TacticConst.immediateForce,
          ],
        );
      }
    }

    return gameState.copyWith(
      lastAction: actionModel,
      allowedActionTypes: allowedActions,
      waitingFootmanLocations: [],
      textLog: PlayPageMessage.of(globalLanguageCode)
          .unitWasRecruited
          .replaceAll(
            "{team}",
            Util.convertTeamIdToTeamName(
              team: gameState.turn,
            ),
          )
          .replaceAll(
            "{unit}",
            Util.convertUnitClassToUnitName(
              unitClass: actionModel.unitsToAction.first.unitClass,
            ),
          ),
    );
  }

  static GameStateModel drawExtraHand({
    required GameStateModel gameState,
    required int seed,
  }) {
    final remainderOfBag = gameState.unitsState
        .where(
          (element) => element.team == gameState.turn && element.layer == HexagonConst.bag,
        )
        .toList();

    final bag = remainderOfBag.isNotEmpty
        ? remainderOfBag
        : gameState.unitsState
            .where(
              (element) =>
                  element.team == gameState.turn && element.location == HexagonConst.discard,
            )
            .toList();

    bag.shuffle(Random(seed));

    final drawUnit = bag.first.copyWith(
      location: "${HexagonConst.hand}4",
      layer: HexagonConst.hand,
    );

    gameState.unitsState.removeWhere(
      (element) => element.unitId == drawUnit.unitId,
    );
    gameState.unitsState.add(
      drawUnit.copyWith(),
    );

    return gameState.copyWith();
  }
}
