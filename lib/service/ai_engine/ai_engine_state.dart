import 'package:equatable/equatable.dart';
import 'package:warchest_dojo/model/action_model.dart';

enum AIEngineStatus {
  initial('初期'),
  inProgress('処理中'),
  success('成功'),
  ;

  const AIEngineStatus(this.message);
  final String message;
}

class AIEngineState extends Equatable {
  const AIEngineState({
    this.status = AIEngineStatus.initial,
    this.selectedAction,
  });

  final AIEngineStatus status;
  final ActionModel? selectedAction;

  AIEngineState copyWith({
    AIEngineStatus? status,
    ActionModel? selectedAction,
  }) {
    return AIEngineState(
      status: status ?? this.status,
      selectedAction: selectedAction ?? this.selectedAction,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedAction,
      ];

  @override
  String toString() => status.message;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.toString(),
        'selectedAction': selectedAction,
      };
}
