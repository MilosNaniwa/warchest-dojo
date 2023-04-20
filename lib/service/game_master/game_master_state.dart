import 'package:equatable/equatable.dart';
import 'package:warchest_dojo/model/game_state_model.dart';

enum GameMasterStatus {
  initial('初期'),
  initializeInProgress('初期化処理中'),
  initializeSuccess('初期化成功'),
  executeActionInProgress('行動実行処理中'),
  executeActionSuccess('行動実行成功'),
  ;

  const GameMasterStatus(this.message);
  final String message;
}

class GameMasterState extends Equatable {
  const GameMasterState({
    this.status = GameMasterStatus.initial,
    this.isAiBluePlayer = false,
    this.currentGameState,
    this.gameStateLog = const [],
    this.textLog = const [],
    this.gameMatchId = '',
  });

  final GameMasterStatus status;
  final bool isAiBluePlayer;
  final GameStateModel? currentGameState;
  final List<GameStateModel?> gameStateLog;
  final List<String?> textLog;
  final String gameMatchId;

  GameMasterState copyWith({
    GameMasterStatus? status,
    GameMasterStatus? previousStatus,
    GameMasterStatus? currentStatus,
    bool? isAiBluePlayer,
    GameStateModel? currentGameState,
    List<GameStateModel?>? gameStateLog,
    List<String?>? textLog,
    String? gameMatchId,
  }) {
    return GameMasterState(
      status: status ?? this.status,
      isAiBluePlayer: isAiBluePlayer ?? this.isAiBluePlayer,
      currentGameState: currentGameState ?? this.currentGameState,
      gameStateLog: gameStateLog ?? this.gameStateLog,
      textLog: textLog ?? this.textLog,
      gameMatchId: gameMatchId ?? this.gameMatchId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isAiBluePlayer,
        currentGameState,
        gameStateLog,
        textLog,
        gameMatchId,
      ];

  @override
  String toString() =>
      "${status.message} (ターン数:${currentGameState == null ? 0 : currentGameState!.snapshotId})";

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.toString(),
        'isAiBluePlayer': isAiBluePlayer,
        'currentGameState': currentGameState?.toJson().toString(),
        'gameStateLog': gameStateLog,
        'textLog': textLog,
        'gameMatchId': gameMatchId,
      };
}
