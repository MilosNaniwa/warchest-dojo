class UnitModel {
  final String unitId;
  final String unitClass;
  final String team;
  final String location;
  final String layer;
  final bool shouldHide;

  const UnitModel({
    required this.unitId,
    required this.unitClass,
    required this.team,
    required this.location,
    required this.layer,
    required this.shouldHide,
  });

  List<Object> get props => [
        unitId,
        unitClass,
        team,
        location,
        layer,
        shouldHide,
      ];

  UnitModel copyWith({
    String? unitId,
    String? unitClass,
    String? team,
    String? location,
    String? layer,
    bool? shouldHide,
  }) =>
      UnitModel(
        unitId: unitId ?? this.unitId,
        unitClass: unitClass ?? this.unitClass,
        team: team ?? this.team,
        location: location ?? this.location,
        layer: layer ?? this.layer,
        shouldHide: shouldHide ?? this.shouldHide,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "unit_id": unitId,
        "unit_class": unitClass,
        "team": team,
        "location": location,
        "layer": layer,
        "should_hide": shouldHide,
      };

  Map<String, dynamic> toJsonWithNormalize() => <String, dynamic>{
        "unit_class": unitClass,
        "layer": layer,
      };

  Map<String, dynamic> toJsonWithLocation() => <String, dynamic>{
        "unit_class": unitClass,
        "location": location,
      };

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      unitId: json["unit_id"],
      unitClass: json["unit_class"],
      team: json["team"],
      location: json["location"],
      layer: json["layer"],
      shouldHide: json["should_hide"],
    );
  }

  @override
  toString() => "$props";
}
