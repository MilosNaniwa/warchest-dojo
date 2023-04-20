import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/control_point_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class GameStateModel {
  final int snapshotId;
  final String turn;
  final String initiative;
  final bool hasChangedInitiative;
  final List<String> unitClassesOfBlue;
  final List<String> unitClassesOfRed;
  final List<ControlPointModel> controlPointsState;
  final List<UnitModel> unitsState;
  final int timestamp;
  final String textLog;
  final List<String> waitingFootmanLocations;
  final ActionModel lastAction;
  final List<String> allowedActionTypes;
  final bool hasGameFinished;
  final String winner;
  final String winningType;

  const GameStateModel({
    required this.snapshotId,
    required this.turn,
    required this.initiative,
    required this.hasChangedInitiative,
    required this.unitClassesOfBlue,
    required this.unitClassesOfRed,
    required this.controlPointsState,
    required this.unitsState,
    required this.timestamp,
    required this.textLog,
    required this.waitingFootmanLocations,
    required this.lastAction,
    required this.allowedActionTypes,
    required this.hasGameFinished,
    required this.winner,
    required this.winningType,
  });

  List<Object> get props => [
        snapshotId,
        turn,
        initiative,
        hasChangedInitiative,
        unitClassesOfBlue,
        unitClassesOfRed,
        controlPointsState,
        unitsState,
        timestamp,
        textLog,
        lastAction,
        allowedActionTypes,
        hasGameFinished,
        winner,
        winningType,
      ];

  GameStateModel copyWith({
    int? snapshotId,
    String? turn,
    String? initiative,
    bool? hasChangedInitiative,
    List<String>? unitClassesOfBlue,
    List<String>? unitClassesOfRed,
    List<ControlPointModel>? controlPointsState,
    List<UnitModel>? unitsState,
    int? timestamp,
    String? textLog,
    List<String>? waitingFootmanLocations,
    ActionModel? lastAction,
    List<String>? allowedActionTypes,
    bool? hasGameFinished,
    String? winner,
    String? winningType,
  }) =>
      GameStateModel(
        snapshotId: snapshotId ?? this.snapshotId,
        turn: turn ?? this.turn,
        initiative: initiative ?? this.initiative,
        hasChangedInitiative: hasChangedInitiative ?? this.hasChangedInitiative,
        unitClassesOfBlue: unitClassesOfBlue ?? this.unitClassesOfBlue,
        unitClassesOfRed: unitClassesOfRed ?? this.unitClassesOfRed,
        controlPointsState: controlPointsState ??
            this
                .controlPointsState
                .map(
                  (e) => e.copyWith(),
                )
                .toList(),
        unitsState: unitsState ??
            this
                .unitsState
                .map(
                  (e) => e.copyWith(),
                )
                .toList(),
        timestamp: timestamp ?? this.timestamp,
        textLog: textLog ?? this.textLog,
        waitingFootmanLocations: waitingFootmanLocations ?? this.waitingFootmanLocations,
        lastAction: lastAction ?? this.lastAction,
        allowedActionTypes: allowedActionTypes ?? this.allowedActionTypes,
        hasGameFinished: hasGameFinished ?? this.hasGameFinished,
        winner: winner ?? this.winner,
        winningType: winningType ?? this.winningType,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "snapshot_id": snapshotId,
        "turn": turn,
        "initiative": initiative,
        "has_changed_initiative": hasChangedInitiative,
        "unit_classes_of_blue": unitClassesOfBlue,
        "unit_classes_of_red": unitClassesOfRed,
        "control_points_state": controlPointsState
            .map(
              (e) => e.toJson(),
            )
            .toList(),
        "units_state": unitsState
            .map(
              (e) => e.toJson(),
            )
            .toList(),
        "timestamp": timestamp,
        "text_log": textLog,
        "waiting_footman_locations": waitingFootmanLocations,
        "last_action": lastAction.toJson(),
        "allowed_actions": allowedActionTypes,
        "has_game_finished": hasGameFinished,
        "winner": winner,
        "winning_type": winningType,
      };

  factory GameStateModel.fromJson(Map<String, dynamic> json) {
    return GameStateModel(
      snapshotId: int.parse(
        json["snapshot_id"].toString(),
      ),
      turn: json["turn"].toString(),
      initiative: json["initiative"].toString(),
      hasChangedInitiative: json["has_changed_initiative"],
      unitClassesOfBlue: (json["unit_classes_of_blue"] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      unitClassesOfRed: (json["unit_classes_of_red"] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      controlPointsState: (json["control_points_state"] as List)
          .map(
            (e) => ControlPointModel.fromJson(e),
          )
          .toList(),
      unitsState: (json["units_state"] as List)
          .map(
            (e) => UnitModel.fromJson(e),
          )
          .toList(),
      timestamp: int.parse(
        json["timestamp"].toString(),
      ),
      textLog: json["text_log"].toString(),
      waitingFootmanLocations: (json["waiting_footman_locations"] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      lastAction: ActionModel.fromJson(
        json["last_action"],
      ),
      allowedActionTypes: (json["allowed_actions"] as List)
          .map(
            (e) => e.toString(),
          )
          .toList(),
      hasGameFinished: json["has_game_finished"],
      winner: json["winner"].toString(),
      winningType: json["winning_type"].toString(),
    );
  }

  @override
  toString() => "$props";
}
