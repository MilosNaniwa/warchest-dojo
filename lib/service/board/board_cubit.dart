import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';
import 'package:warchest_dojo/service/board/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit()
      : super(
          const BoardState(),
        );

  void changeHoverTile({
    required String tileId,
  }) {
    emit(
      state.copyWith(
        hovered: tileId,
      ),
    );
  }

  void removeOtherActions({
    required GameStateModel gameStateModel,
    required String actionType,
    required UnitModel unitToUse,
    List<ActionModel>? actions,
    bool isInstructedAction = false,
  }) {
    final tmpSelectedUnit = unitToUse.copyWith();

    final tmpActions = actions ??
        RuleEngine.listUpActions(
          unitToUse: unitToUse,
          gameState: gameStateModel,
        );

    emit(
      state.copyWith(
        actions: tmpActions
          ..removeWhere(
            (element) => element.actionType != actionType,
          ),
        hovered: '',
        focusedTileId: "",
        selectedUnit: tmpSelectedUnit,
        dominatableList: [],
        bolsterableList: [],
        instructableList: [],
        movableList: [],
        attackableList: [],
        deployableList: [],
      ),
    );

    displayActionable(
      gameStateModel: gameStateModel,
      isInstructedAction: isInstructedAction,
      unitToUse: unitToUse,
      actions: state.actions
          .map(
            (e) => e!,
          )
          .toList(),
    );
  }

  void removeSomeActions({
    required GameStateModel gameStateModel,
    required UnitModel unitToUse,
    List<ActionModel>? actions,
    required List<String> removeActions,
    required String selectedLocation,
    bool isInstructedAction = false,
  }) {
    final tmpSelectedUnit = unitToUse.copyWith();

    final tmpActions = actions ??
        RuleEngine.listUpActions(
          unitToUse: unitToUse,
          gameState: gameStateModel,
        );

    emit(
      state.copyWith(
        actions: tmpActions
          ..removeWhere(
            (element) =>
                removeActions.contains(element.actionType) &&
                element.unitsToAction.first.location != selectedLocation,
          ),
        hovered: '',
        focusedTileId: "",
        selectedUnit: tmpSelectedUnit,
        dominatableList: [],
        bolsterableList: [],
        instructableList: [],
        movableList: [],
        attackableList: [],
        deployableList: [],
      ),
    );
    displayActionable(
      gameStateModel: gameStateModel,
      isInstructedAction: isInstructedAction,
      unitToUse: unitToUse,
      actions: state.actions
          .map(
            (e) => e!,
          )
          .toList(),
    );
  }

  void clearFocus() {
    emit(
      state.copyWith(
        hovered: '',
        focusedTileId: "",
        actions: [],
        selectedUnit: const UnitModel(
          unitId: UnitClassConst.none,
          unitClass: UnitClassConst.none,
          team: HexagonConst.neutral,
          location: HexagonConst.none,
          layer: UnitClassConst.none,
          shouldHide: false,
        ),
        dominatableList: [],
        bolsterableList: [],
        instructableList: [],
        movableList: [],
        attackableList: [],
        deployableList: [],
      ),
    );
  }

  void focusTile({
    required String tileId,
  }) {
    emit(
      state.copyWith(
        focusedTileId: tileId,
      ),
    );
  }

  void changeRedTeamToggle({
    required int index,
  }) {
    emit(
      state.copyWith(
        redTeamDiscardToggle: index,
      ),
    );
  }

  void changeBlueTeamToggle({
    required int index,
  }) {
    emit(
      state.copyWith(
        blueTeamDiscardToggle: index,
      ),
    );
  }

  void displayActionable({
    required GameStateModel gameStateModel,
    bool isInstructedAction = false,
    required UnitModel unitToUse,
    List<ActionModel>? actions,
  }) {
    final tmpActions = actions ??
        RuleEngine.listUpActions(
          unitToUse: unitToUse,
          gameState: gameStateModel,
        );

    final movableList = tmpActions
        .where(
          (element) =>
              element.actionType == ActionTypeConst.move ||
              (isInstructedAction && element.actionType == ActionTypeConst.instructionMove),
        )
        .map(
          (e) => e.targetLocation,
        )
        .toList();

    final attackableList = tmpActions
        .where(
          (element) =>
              element.actionType == ActionTypeConst.attack ||
              (isInstructedAction && element.actionType == ActionTypeConst.instructionAttack),
        )
        .map(
          (e) => e.targetLocation,
        )
        .toList();

    final deployableList = tmpActions
        .where(
          (element) => element.actionType == ActionTypeConst.deploy,
        )
        .map(
          (e) => e.targetLocation,
        )
        .toList();

    final bolsterableList = tmpActions
        .where(
          (element) => element.actionType == ActionTypeConst.bolster,
        )
        .map(
          (e) => e.targetLocation,
        )
        .toList();

    final dominatableList = tmpActions
        .where(
          (element) => element.actionType == ActionTypeConst.dominate,
        )
        .map(
          (e) => e.targetLocation,
        )
        .toList();

    final instructableList = tmpActions
        .where(
          (element) =>
              element.actionType == ActionTypeConst.instructionAttack ||
              element.actionType == ActionTypeConst.instructionMove,
        )
        .map(
          (e) => e.unitsToAction.first.location,
        )
        .toSet()
        .toList();

    emit(
      state.copyWith(
        selectedUnit: unitToUse,
        actions: tmpActions,
        movableList: movableList,
        attackableList: attackableList,
        deployableList: deployableList,
        bolsterableList: bolsterableList,
        dominatableList: dominatableList,
        instructableList: instructableList,
      ),
    );
  }
}
