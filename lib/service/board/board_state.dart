import 'package:equatable/equatable.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class BoardState extends Equatable {
  const BoardState({
    this.focusedTileId = '',
    this.hovered = '',
    this.reversed = false,
    this.blueTeamDiscardToggle = 0,
    this.redTeamDiscardToggle = 0,
    this.movableList = const [],
    this.attackableList = const [],
    this.deployableList = const [],
    this.dominatableList = const [],
    this.bolsterableList = const [],
    this.instructableList = const [],
    this.selectedUnit = const UnitModel(
      unitId: UnitClassConst.none,
      unitClass: UnitClassConst.none,
      team: HexagonConst.neutral,
      location: HexagonConst.none,
      layer: UnitClassConst.none,
      shouldHide: false,
    ),
    this.actions = const [],
  });

  final String focusedTileId;
  final String hovered;
  final bool reversed;
  final int blueTeamDiscardToggle;
  final int redTeamDiscardToggle;
  final List<String?> movableList;
  final List<String?> attackableList;
  final List<String?> deployableList;
  final List<String?> dominatableList;
  final List<String?> bolsterableList;
  final List<String?> instructableList;
  final UnitModel? selectedUnit;
  final List<ActionModel?> actions;

  BoardState copyWith({
    String? focusedTileId,
    String? hovered,
    bool? reversed,
    int? blueTeamDiscardToggle,
    int? redTeamDiscardToggle,
    List<String?>? movableList,
    List<String?>? attackableList,
    List<String?>? deployableList,
    List<String?>? dominatableList,
    List<String?>? bolsterableList,
    List<String?>? instructableList,
    UnitModel? selectedUnit,
    List<ActionModel?>? actions,
    List<GameStateModel?>? gameStateLog,
    List<String?>? textLog,
    String? chatBotMessage,
  }) {
    return BoardState(
      focusedTileId: focusedTileId ?? this.focusedTileId,
      hovered: hovered ?? this.hovered,
      reversed: reversed ?? this.reversed,
      blueTeamDiscardToggle: blueTeamDiscardToggle ?? this.blueTeamDiscardToggle,
      redTeamDiscardToggle: redTeamDiscardToggle ?? this.redTeamDiscardToggle,
      movableList: movableList ?? this.movableList,
      attackableList: attackableList ?? this.attackableList,
      deployableList: deployableList ?? this.deployableList,
      dominatableList: dominatableList ?? this.dominatableList,
      bolsterableList: bolsterableList ?? this.bolsterableList,
      instructableList: instructableList ?? this.instructableList,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      actions: actions ?? this.actions,
    );
  }

  @override
  List<Object?> get props => [
        focusedTileId,
        hovered,
        reversed,
        blueTeamDiscardToggle,
        redTeamDiscardToggle,
        movableList,
        attackableList,
        deployableList,
        dominatableList,
        bolsterableList,
        instructableList,
        selectedUnit,
        actions,
      ];

  @override
  String toString() => "hovered: $hovered";

  Map<String, dynamic> toJson() => <String, dynamic>{
        'focusedTileId': focusedTileId,
        'hovered': hovered,
        'reversed': reversed,
        'blueTeamDiscardToggle': blueTeamDiscardToggle,
        'redTeamDiscardToggle': redTeamDiscardToggle,
        'movableList': movableList,
        'attackableList': attackableList,
        'deployableList': deployableList,
        'dominatableList': dominatableList,
        'bolsterableList': bolsterableList,
        'instructableList': instructableList,
        'selectedUnit': selectedUnit?.toJson().toString(),
        'actions': actions
            .map(
              (e) => e!.toJson(),
            )
            .toList(),
      };
}
