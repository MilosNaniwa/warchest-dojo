import 'package:warchest_dojo/model/unit_model.dart';

class ActionModel {
  final String team;
  final String actionType;
  final List<UnitModel> unitsToAction;
  final String targetLocation;
  final UnitModel unitToUse;

  const ActionModel({
    required this.team,
    required this.actionType,
    required this.unitsToAction,
    required this.targetLocation,
    required this.unitToUse,
  });

  List<Object> get props => [
        team,
        actionType,
        unitsToAction,
        targetLocation,
        unitToUse,
      ];

  ActionModel copyWith({
    String? team,
    String? actionType,
    List<UnitModel>? unitsToAction,
    String? targetLocation,
    UnitModel? unitToUse,
  }) =>
      ActionModel(
        team: team ?? this.team,
        actionType: actionType ?? this.actionType,
        unitsToAction: unitsToAction ?? this.unitsToAction,
        targetLocation: targetLocation ?? this.targetLocation,
        unitToUse: unitToUse ?? this.unitToUse,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "team": team,
        "action_type": actionType,
        "units_to_action": unitsToAction
            .map(
              (e) => e.toJson(),
            )
            .toList(),
        "target_location": targetLocation,
        "unit_to_use": unitToUse.toJson(),
      };

  Map<String, dynamic> toJsonWithNormalize() => <String, dynamic>{
        "action_type": actionType,
        "units_to_action": unitsToAction
            .map(
              (e) => e.toJsonWithLocation(),
            )
            .toList(),
        "target_location": targetLocation,
        "unit_to_use": unitToUse.toJsonWithNormalize(),
      };

  factory ActionModel.fromJson(Map<String, dynamic> json) {
    return ActionModel(
      team: json["team"],
      actionType: json["action_type"],
      unitsToAction: (json["units_to_action"] as List)
          .map(
            (e) => UnitModel.fromJson(e),
          )
          .toList(),
      targetLocation: json["target_location"],
      unitToUse: UnitModel.fromJson(
        json["unit_to_use"],
      ),
    );
  }

  @override
  toString() => "$props";
}
