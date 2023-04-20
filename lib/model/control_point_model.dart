class ControlPointModel {
  final String tileId;
  final String dominatedBy;

  const ControlPointModel({
    required this.tileId,
    required this.dominatedBy,
  });

  List<Object> get props => [
        tileId,
        dominatedBy,
      ];

  ControlPointModel copyWith({
    String? tileId,
    String? dominatedBy,
  }) =>
      ControlPointModel(
        tileId: tileId ?? this.tileId,
        dominatedBy: dominatedBy ?? this.dominatedBy,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "tile_id": tileId,
        "dominated_by": dominatedBy,
      };

  factory ControlPointModel.fromJson(Map<String, dynamic> json) {
    return ControlPointModel(
      tileId: json["tile_id"],
      dominatedBy: json["dominated_by"],
    );
  }

  @override
  toString() => "$props";
}
