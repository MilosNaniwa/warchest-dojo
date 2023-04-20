import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/play_page_message.dart';
import 'package:warchest_dojo/localization/unit_characteristic.dart.dart';
import 'package:warchest_dojo/localization/unit_description.dart';
import 'package:warchest_dojo/localization/unit_name.dart';
import 'package:warchest_dojo/localization/unit_tactic.dart';
import 'package:warchest_dojo/model/game_state_model.dart';

class Util {
  static String convertUnitClassToUnitName({
    required String unitClass,
  }) {
    return UnitName.of(globalLanguageCode).unitClass(unitClass);
  }

  static String convertUnitClassToUnitDescription({
    required String unitClass,
  }) {
    return UnitDescription.of(globalLanguageCode).unitClass(unitClass);
  }

  static String convertUnitClassToUnitTactic({
    required String unitClass,
  }) {
    return UnitTactic.of(globalLanguageCode).unitClass(unitClass);
  }

  static String convertUnitClassToUnitCharacteristic({
    required String unitClass,
  }) {
    return UnitCharacteristic.of(globalLanguageCode).unitClass(unitClass);
  }

  static String convertCoordinateToTileName({
    required int coordinateX,
    required int coordinateY,
  }) {
    final columnId = () {
      switch (coordinateX) {
        case 0:
          return "A";
        case 1:
          return "B";
        case 2:
          return "C";
        case 3:
          return "D";
        case 4:
          return "E";
        case 5:
          return "F";
        case 6:
          return "G";
        default:
          return "";
      }
    }();

    final rowId = () {
      switch (coordinateX) {
        case 0:
          return coordinateY - 1;
        case 1:
          return coordinateY;
        case 2:
          return coordinateY;
        case 3:
          return coordinateY + 1;
        case 4:
          return coordinateY;
        case 5:
          return coordinateY;
        case 6:
          return coordinateY - 1;
        default:
          return "";
      }
    }();

    return "$columnId–$rowId";
  }

  static String convertTileIdToTileName({
    required String tileId,
  }) {
    final separated = tileId.split("–");
    final tileName = convertCoordinateToTileName(
      coordinateX: int.parse(separated[0]),
      coordinateY: int.parse(separated[1]),
    );
    return tileName;
  }

  static String convertTeamIdToTeamName({
    required String team,
  }) {
    return team == HexagonConst.playerBlue
        ? PlayPageMessage.of(globalLanguageCode).player
        : PlayPageMessage.of(globalLanguageCode).computer;
  }

  static List<int> quantizeGameState({
    required GameStateModel gameState,
  }) {
    final controlPointState = HexagonConst.controlPointsTile.map(
      (e) {
        final control = gameState.controlPointsState.firstWhere(
          (element) => element.tileId == e,
        );

        switch (control.dominatedBy) {
          case HexagonConst.neutral:
            return 0;
          case HexagonConst.playerBlue:
            return 1;
          case HexagonConst.playerRed:
            return 2;
          default:
            throw Error();
        }
      },
    );
    final handState = UnitClassConst.allUnitCoin.map(
      (e) => gameState.unitsState
          .where(
            (element) =>
                [
                  HexagonConst.hand,
                ].contains(element.layer) &&
                element.unitClass == e,
          )
          .length,
    );
    final bagState = UnitClassConst.allUnitCoin.map(
      (e) => gameState.unitsState
          .where(
            (element) =>
                [
                  HexagonConst.bag,
                ].contains(element.layer) &&
                element.unitClass == e,
          )
          .length,
    );
    final discardState = UnitClassConst.allUnitCoin.map(
      (e) => gameState.unitsState
          .where(
            (element) =>
                [
                  HexagonConst.discard,
                ].contains(element.layer) &&
                element.unitClass == e,
          )
          .length,
    );
    final cemeteryState = UnitClassConst.allCharacterCoin.map(
      (e) => gameState.unitsState
          .where(
            (element) =>
                [
                  HexagonConst.cemetery,
                ].contains(element.layer) &&
                element.unitClass == e,
          )
          .length,
    );
    final supplyState = UnitClassConst.allCharacterCoin.map(
      (e) => gameState.unitsState
          .where(
            (element) =>
                [
                  HexagonConst.supply,
                ].contains(element.layer) &&
                element.unitClass == e,
          )
          .length,
    );
    final boardState = HexagonConst.availableTile
        .map(
          (e) => UnitClassConst.allCharacterCoin.map(
            (element) => gameState.unitsState
                .where(
                  (unit) => unit.location == e && unit.unitClass == element,
                )
                .length,
          ),
        )
        .expand(
          (element) => element,
        );

    final quantizedState = <int>[
      ...controlPointState,
      ...handState,
      ...bagState,
      ...discardState,
      ...cemeteryState,
      ...supplyState,
      ...boardState,
    ];

    return quantizedState;
  }

  static List<dynamic> recordGameState({
    required int gameId,
    required GameStateModel gameState,
  }) {
    final List<dynamic> gameIdList = [
      gameId + 1,
    ];
    final winnerList = [
      gameState.winner == HexagonConst.playerBlue ? 1 : 2,
    ];
    final actionIdList = [
      gameState.snapshotId + 1,
    ];
    final textLogList = [
      gameState.textLog,
    ];
    final initiativeState = [
      gameState.initiative == HexagonConst.playerBlue ? 1 : 2,
    ];
    final turnState = [
      gameState.turn == HexagonConst.playerBlue ? 1 : 2,
    ];
    final teamState = UnitClassConst.allUnitCoin.map(
      (e) {
        if (gameState.unitClassesOfBlue.contains(e)) {
          return 1;
        }
        if (gameState.unitClassesOfRed.contains(e)) {
          return 2;
        }
        return 0;
      },
    ).toList();
    final controlPointState = HexagonConst.controlPointsTile.map(
      (e) {
        final control = gameState.controlPointsState.firstWhere(
          (element) => element.tileId == e,
        );

        switch (control.dominatedBy) {
          case HexagonConst.neutral:
            return 0;
          case HexagonConst.playerBlue:
            return 1;
          case HexagonConst.playerRed:
            return 2;
          default:
            throw Error();
        }
      },
    ).toList();
    final handState = UnitClassConst.allUnitCoin
        .map(
          (e) => gameState.unitsState
              .where(
                (element) => element.layer == HexagonConst.hand && element.unitClass == e,
              )
              .length,
        )
        .toList();
    final discardOpenedState = UnitClassConst.allUnitCoin
        .map(
          (e) => gameState.unitsState
              .where(
                (element) =>
                    element.layer == HexagonConst.discard &&
                    element.unitClass == e &&
                    element.shouldHide == false,
              )
              .length,
        )
        .toList();
    final discardHiddenState = UnitClassConst.allUnitCoin
        .map(
          (e) => gameState.unitsState
              .where(
                (element) =>
                    element.layer == HexagonConst.discard &&
                    element.unitClass == e &&
                    element.shouldHide == true,
              )
              .length,
        )
        .toList();
    final cemeteryState = UnitClassConst.allCharacterCoin
        .map(
          (e) => gameState.unitsState
              .where(
                (element) => element.layer == HexagonConst.cemetery && element.unitClass == e,
              )
              .length,
        )
        .toList();
    final supplyState = UnitClassConst.allCharacterCoin
        .map(
          (e) => gameState.unitsState
              .where(
                (element) => element.layer == HexagonConst.supply && element.unitClass == e,
              )
              .length,
        )
        .toList();
    final boardState = HexagonConst.availableTile
        .map(
          (e) => UnitClassConst.allCharacterCoin.map(
            (element) => gameState.unitsState
                .where(
                  (unit) => unit.location == e && unit.unitClass == element,
                )
                .length,
          ),
        )
        .expand(
          (element) => element,
        )
        .toList();

    final List quantizedState = gameIdList +
        winnerList +
        actionIdList +
        textLogList +
        initiativeState +
        turnState +
        teamState +
        controlPointState +
        handState +
        discardOpenedState +
        discardHiddenState +
        cemeteryState +
        supplyState +
        boardState;

    return quantizedState;
  }

  static List<String> generateHeader() {
    final gameId = [
      "game_id",
    ];
    final winnerList = [
      "winner",
    ];
    final actionId = [
      "action_id",
    ];
    final textLogList = [
      "log",
    ];
    final initiativeState = [
      "initiative",
    ];
    final turnState = [
      "turn",
    ];
    final teamState = UnitClassConst.allUnitCoin
        .map(
          (e) => "team_$e",
        )
        .toList();
    final controlPointState = HexagonConst.controlPointsTile
        .map(
          (element) => "control_$element",
        )
        .toList();
    final handState = UnitClassConst.allUnitCoin
        .map(
          (e) => "hand_$e",
        )
        .toList();
    final discardOpenedState = UnitClassConst.allUnitCoin
        .map(
          (e) => "discard_open_$e",
        )
        .toList();
    final discardHiddenState = UnitClassConst.allUnitCoin
        .map(
          (e) => "discard_hidden_$e",
        )
        .toList();
    final cemeteryState = UnitClassConst.allCharacterCoin
        .map(
          (e) => "cemetery_$e",
        )
        .toList();
    final supplyState = UnitClassConst.allCharacterCoin
        .map(
          (e) => "supply_$e",
        )
        .toList();
    final boardState = HexagonConst.availableTile
        .map(
          (e) => UnitClassConst.allCharacterCoin.map(
            (element) => "tile_${e}_$element",
          ),
        )
        .expand(
          (element) => element,
        )
        .toList();

    final header = gameId +
        winnerList +
        actionId +
        textLogList +
        initiativeState +
        turnState +
        teamState +
        controlPointState +
        handState +
        discardOpenedState +
        discardHiddenState +
        cemeteryState +
        supplyState +
        boardState;

    return header;
  }
}
