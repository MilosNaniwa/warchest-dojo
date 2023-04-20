import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/service/game_master/game_master_state.dart';

class GameMasterCubit extends Cubit<GameMasterState> {
  GameMasterCubit()
      : super(
          const GameMasterState(),
        );

  void initialize({
    required bool aiMode,
    required List<String> playerUnitList,
    required List<String> aiUnitList,
    required String difficulty,
  }) async {
    emit(
      state.copyWith(
        status: GameMasterStatus.initializeInProgress,
      ),
    );

    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('game').doc();

    if (difficulty == HexagonConst.prototype) {
      final packageInfo = await PackageInfo.fromPlatform();
      final FirebaseAuth auth = FirebaseAuth.instance;
      await firestore.collection('prototype').doc(docRef.id).set(
        {
          "create_timestamp": FieldValue.serverTimestamp(),
          "update_timestamp": FieldValue.serverTimestamp(),
          "player_id": auth.currentUser!.uid,
          "version": packageInfo.version,
          "build_number": packageInfo.buildNumber,
          "difficulty": difficulty,
          "chat_mode": globalChatMode,
          "kanji_mode": globalKanjiMode,
          "language": globalLanguageCode,
        },
      );
    }

    // Randomize which team goes first
    final teamList = [
      HexagonConst.playerBlue,
      HexagonConst.playerRed,
    ]..shuffle();

    // Initialize the game state
    final currentGameState = RuleEngine.initializeGame(
      unitClassListOfBlue: playerUnitList,
      unitClassListOfRed: aiUnitList,
      initiative: teamList.first,
      difficulty: difficulty,
    );

    emit(
      state.copyWith(
        status: GameMasterStatus.initializeSuccess,
        isAiBluePlayer: aiMode,
        currentGameState: currentGameState,
        gameStateLog: [currentGameState],
        textLog: ["", "", "", "", "", ""],
        gameMatchId: docRef.id,
      ),
    );
  }

  void executeAction({
    required ActionModel actionModel,
  }) {
    emit(
      state.copyWith(
        status: GameMasterStatus.executeActionInProgress,
      ),
    );

    final tmpCurrentGameState = RuleEngine.executeAction(
      action: actionModel,
      gameState: state.currentGameState!,
    );

    final nextGameState = RuleEngine.forwardToNextState(
      gameState: tmpCurrentGameState,
    );

    emit(
      state.copyWith(
        status: GameMasterStatus.executeActionSuccess,
        currentGameState: nextGameState,
        gameStateLog: state.gameStateLog
          ..add(
            nextGameState,
          ),
        textLog: state.textLog
          ..insert(
            0,
            nextGameState.textLog,
          ),
      ),
    );
  }

  Future<void> recordGameLog({
    required String difficulty,
  }) async {
    final batch = FirebaseFirestore.instance.batch();
    final docRef = FirebaseFirestore.instance.collection('game').doc(state.gameMatchId);

    final packageInfo = await PackageInfo.fromPlatform();

    final FirebaseAuth auth = FirebaseAuth.instance;

    batch.set(
      docRef,
      {
        "create_timestamp": FieldValue.serverTimestamp(),
        "player_id": auth.currentUser!.uid,
        "winner": state.currentGameState!.winner,
        "version": packageInfo.version,
        "build_number": packageInfo.buildNumber,
        "difficulty": difficulty,
        "chat_mode": globalChatMode,
        "kanji_mode": globalKanjiMode,
        "language": globalLanguageCode,
      },
    );
    for (int i = 0; i < state.gameStateLog.length; i++) {
      batch.set(
        docRef.collection("log").doc(),
        state.gameStateLog[i]!.toJson(),
      );
    }
    await batch.commit();
  }
}
