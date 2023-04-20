import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/game_engine/ai_engine_rule_based_alpha.dart';
import 'package:warchest_dojo/game_engine/ai_engine_rule_based_delta.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/service/ai_engine/ai_engine_state.dart';

class AIEngineCubit extends Cubit<AIEngineState> {
  AIEngineCubit()
      : super(
          const AIEngineState(),
        );

  void findBestAction({
    required GameStateModel gameStateModel,
    required String difficulty,
    required int aiThinkingTime,
  }) async {
    emit(
      state.copyWith(
        status: AIEngineStatus.inProgress,
      ),
    );

    final action = _chooseAiAction(
      gameStateModel: gameStateModel,
      difficulty: difficulty,
    );

    if (difficulty != HexagonConst.prototype) {
      await Future.delayed(Duration(milliseconds: aiThinkingTime));
    }

    emit(
      state.copyWith(
        status: AIEngineStatus.success,
        selectedAction: action,
      ),
    );
  }

  ActionModel _chooseAiAction({
    required GameStateModel gameStateModel,
    required String difficulty,
  }) {
    if (gameStateModel.turn == HexagonConst.playerRed && difficulty == HexagonConst.prototype) {
      return AiEngineRuleBasedAiDelta.choiceAction(
        gameState: gameStateModel,
        player: HexagonConst.playerRed,
        opponent: HexagonConst.playerBlue,
      );
    }

    if (gameStateModel.turn == HexagonConst.playerRed) {
      final allActions = RuleEngine.listUpAllActions(
        gameState: gameStateModel,
      );
      return AiEngineRuleBasedAiAlpha.choiceAction(
        actions: allActions,
        gameState: gameStateModel,
      );
    }

    return AiEngineRuleBasedAiDelta.choiceAction(
      gameState: gameStateModel,
      player: HexagonConst.playerBlue,
      opponent: HexagonConst.playerRed,
    );
  }

  void fetchBestActionFromCloud({
    required GameStateModel gameStateModel,
    required String gameMatchId,
  }) async {
    emit(
      state.copyWith(
        status: AIEngineStatus.inProgress,
      ),
    );

    // 現状をFirestoreに書き込む
    final firestore = FirebaseFirestore.instance;

    final docRef = await firestore.collection('prototype').doc(gameMatchId).collection('game').add({
      "game_state": {
        ...gameStateModel.toJson(),
      },
      "create_timestamp": FieldValue.serverTimestamp(),
    });

    // 探索の進捗を出力する
    await Future.delayed(const Duration(seconds: 10));

    Stopwatch stopwatch = Stopwatch()..start();
    while (stopwatch.elapsed < const Duration(seconds: 5)) {
      // 探索結果を出力する
      final snapshot = await docRef.get();
      final actionJson = snapshot.data()!["action"];
      if (actionJson != null) {
        final action = ActionModel.fromJson(snapshot.data()!["action"]);

        emit(
          state.copyWith(
            status: AIEngineStatus.success,
            selectedAction: action,
          ),
        );

        return;
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    final action = _chooseAiAction(
      gameStateModel: gameStateModel,
      difficulty: HexagonConst.sergeant,
    );

    emit(
      state.copyWith(
        status: AIEngineStatus.success,
        selectedAction: action,
      ),
    );
  }
}
