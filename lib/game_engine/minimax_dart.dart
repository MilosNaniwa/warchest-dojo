import 'dart:math';

import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/log.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class MiniMaxCalculation {
  // Add a constant for the maximum search time allowed (in milliseconds)
  static const int maxSearchTime = 3000;

  // Transposition table to store previously evaluated game states
  static Map<String, Map<int, double>> transpositionTable = {};

  // Function to generate a unique hash for a given game state
  static String _hashGameState(GameStateModel state) {
    return state.toJson().toString();
  }

  // Updated findBestMove function to use iterative deepening
  static ActionModel findBestMove(GameStateModel state, String player) {
    DateTime startTime = DateTime.now();
    double bestEvaluation = double.negativeInfinity;
    String bestMoveTextLog = "";
    List<ActionModel> possibleMoves = RuleEngine.listUpAllActions(gameState: state);
    possibleMoves.shuffle();
    ActionModel bestMove = possibleMoves.first;

    for (int depth = 1; depth < 5; depth++) {
      Log.debug(
        message: "深さ: $depth",
      );
      double currentDepthBestEvaluation = double.negativeInfinity;
      ActionModel currentDepthBestMove = bestMove;

      for (ActionModel action in possibleMoves) {
        GameStateModel newState = _executeActionAndForwardToNextState(state, action);
        double evaluation = _minimaxAlphaBeta(
          state: newState,
          depth: depth,
          alpha: double.negativeInfinity,
          beta: double.infinity,
          maximizingPlayer: false,
          player: player,
          moveNumber: 1,
        );
        Log.debug(
          message: "探索案: ${newState.textLog}\n評価値: $evaluation",
        );
        if (evaluation > currentDepthBestEvaluation) {
          currentDepthBestMove = action;
          currentDepthBestEvaluation = evaluation;
          bestMoveTextLog = newState.textLog;
        }
      }

      bestMove = currentDepthBestMove;
      bestEvaluation = currentDepthBestEvaluation;

      // Check if search time has exceeded the maximum allowed time
      if (DateTime.now().difference(startTime).inMilliseconds >= maxSearchTime) {
        break;
      }
    }

    Log.debug(
      message: "最終探索案: $bestMoveTextLog\n最終評価値: $bestEvaluation",
    );

    return bestMove;
  }

  static GameStateModel _executeActionAndForwardToNextState(
    GameStateModel state,
    ActionModel action,
  ) {
    return RuleEngine.forwardToNextState(
      gameState: RuleEngine.executeAction(
        action: action,
        gameState: state,
      ),
    );
  }

  static double _minimaxAlphaBeta({
    required GameStateModel state,
    required int depth,
    required double alpha,
    required double beta,
    required bool maximizingPlayer,
    required String player,
    required int moveNumber,
    bool allowNullMove = true,
  }) {
    if (state.hasGameFinished) return _evaluatePosition(state, player);

    if (depth < 1) {
      return _evaluatePosition(state, player);
    }

    String stateHash = _hashGameState(state);
    if (transpositionTable.containsKey(stateHash) &&
        transpositionTable[stateHash]!.containsKey(depth)) {
      return transpositionTable[stateHash]![depth]!;
    }

    // Null move pruning
    if (allowNullMove && depth >= 3 && _isSafeToPerformNullMove(state, player)) {
      double nullMoveEvaluation = -_evaluatePosition(state, player);
      if (nullMoveEvaluation >= beta) return nullMoveEvaluation;
    }

    List<ActionModel> possibleMoves = RuleEngine.listUpAllActions(gameState: state);
    possibleMoves.sort(
      (a, b) {
        GameStateModel newStateA = _executeActionAndForwardToNextState(state, a);
        GameStateModel newStateB = _executeActionAndForwardToNextState(state, b);
        double evalA = _evaluatePosition(newStateA, player);
        double evalB = _evaluatePosition(newStateB, player);
        return maximizingPlayer ? evalB.compareTo(evalA) : evalA.compareTo(evalB);
      },
    );

    double evaluation = maximizingPlayer ? double.negativeInfinity : double.infinity;

    // Move ordering and the rest of the minimax algorithm
    for (int moveIndex = 0; moveIndex < possibleMoves.length; moveIndex++) {
      ActionModel move = possibleMoves[moveIndex];
      GameStateModel newState = _executeActionAndForwardToNextState(state, move);

      double childEvaluation = _minimaxAlphaBeta(
        state: newState,
        depth: depth - 1,
        alpha: alpha,
        beta: beta,
        maximizingPlayer: !maximizingPlayer,
        player: player,
        moveNumber: moveNumber + 1,
      );

      if (maximizingPlayer) {
        evaluation = max(evaluation, childEvaluation);
        alpha = max(alpha, evaluation);
      } else {
        evaluation = min(evaluation, childEvaluation);
        beta = min(beta, evaluation);
      }
      if (alpha >= beta) break;
    }

    // Add evaluation to the transposition table with depth
    if (!transpositionTable.containsKey(stateHash)) {
      transpositionTable[stateHash] = {};
    }
    transpositionTable[stateHash]![depth] = evaluation;
    return evaluation;
  }

  static bool _isSafeToPerformNullMove(GameStateModel state, String player) {
    String opponent =
        player == HexagonConst.playerBlue ? HexagonConst.playerRed : HexagonConst.playerBlue;

    // Example condition 1: Don't perform a null move if the player has few controlled royal locations
    int playerControlledRoyalLocations = state.controlPointsState
        .where(
          (e) => e.dominatedBy == player,
        )
        .length;
    int opponentControlledRoyalLocations = state.controlPointsState
        .where(
          (e) => e.dominatedBy == opponent,
        )
        .length;
    if (playerControlledRoyalLocations - opponentControlledRoyalLocations < 2) {
      return false;
    }

    // Example condition 2: Don't perform a null move if the opponent has a considerable advantage in unit strength
    int playerUnitStrength = state.unitsState
        .where(
          (element) => element.team == player && element.layer == HexagonConst.board,
        )
        .map(
          (e) => e.location,
        )
        .toSet()
        .length;
    int opponentUnitStrength = state.unitsState
        .where(
          (element) => element.team == opponent && element.layer == HexagonConst.board,
        )
        .map(
          (e) => e.location,
        )
        .toSet()
        .length;
    if (opponentUnitStrength >= playerUnitStrength * 1.2) {
      return false;
    }

    return true;
  }

  static Map<String, double> evaluationCache = {};

  static double _evaluatePosition(GameStateModel state, String player) {
    String stateHash = _hashGameState(state);
    if (evaluationCache.containsKey(stateHash)) {
      return evaluationCache[stateHash]!;
    }

    String opponent =
        player == HexagonConst.playerBlue ? HexagonConst.playerRed : HexagonConst.playerBlue;

    int playerControlledRoyalLocations = state.controlPointsState
        .where(
          (e) => e.dominatedBy == player,
        )
        .length;
    int opponentControlledRoyalLocations = state.controlPointsState
        .where(
          (e) => e.dominatedBy == opponent,
        )
        .length;

    double playerScore = _evaluateUnits(state, player) +
        400 * playerControlledRoyalLocations +
        _evaluateInitiative(state, player);
    double opponentScore = _evaluateUnits(state, opponent) +
        400 * opponentControlledRoyalLocations +
        _evaluateInitiative(state, opponent);

    double finalScore = playerScore - opponentScore;

    // Cache the evaluation result
    evaluationCache[stateHash] = finalScore;

    return finalScore;
  }

  static double _evaluateInitiative(GameStateModel state, String player) {
    // Add code to evaluate the player's initiative based on the number of initiative tokens they have claimed
    // Example: return state.initiativeTokens[player] * 10;
    return state.initiative == player ? 10 : 0;
  }

  static double _evaluateUnits(GameStateModel state, String player) {
    double score = 0;

    for (String location in state.unitsState
        .where(
          (u) => u.team == player && u.layer == HexagonConst.board,
        )
        .map(
          (e) => e.location,
        )
        .toSet()
        .toList()) {
      score += _evaluateUnit(
        state,
        state.unitsState.firstWhere(
          (u) => u.location == location,
        ),
      );
    }

    return score;
  }

  static double _evaluateUnit(GameStateModel state, UnitModel unit) {
    double score = 100;

    final distanceOfNearestRoyalLocation = _computeNearestRoyalLocationDistance(
      unitLocation: unit.location,
      player: unit.team,
      gameState: state,
    );

    if (distanceOfNearestRoyalLocation < 1) {
      score += 100;
    }

    if (distanceOfNearestRoyalLocation < 2) {
      score += 100;
    }

    if (distanceOfNearestRoyalLocation < 3) {
      score += 100;
    }

    return score;
  }

  static int _computeNearestRoyalLocationDistance({
    required String unitLocation,
    required String player,
    required GameStateModel gameState,
  }) {
    // 盤上の自陣営以外の拠点を全てリストアップ
    final allTargetArea = gameState.controlPointsState
        .where(
          (element) => element.dominatedBy != player,
        )
        .map(
          (e) => e.tileId,
        )
        .toList();

    // 自分以外の味方が存在する地点は排除
    allTargetArea.removeWhere(
      (element) => gameState.unitsState
          .where(
            (element) => element.team == player && element.location != unitLocation,
          )
          .toSet()
          .map(
            (e) => e.location,
          )
          .contains(element),
    );

    // 行動するユニットから最も近い目標を算出
    allTargetArea.sort(
      (a, b) {
        final distanceA = Emulator.emulateDistance(
          currentTile: unitLocation,
          targetTile: a,
        );
        final distanceB = Emulator.emulateDistance(
          currentTile: unitLocation,
          targetTile: b,
        );

        if (distanceA < distanceB) {
          return -1;
        }

        if (distanceA > distanceB) {
          return 1;
        }

        if (gameState.unitsState
            .where(
              (element) => element.location == a,
            )
            .isNotEmpty) {
          if (gameState.unitsState
              .where(
                (element) => element.location == b,
              )
              .isNotEmpty) {
            return 0;
          } else {
            return 1;
          }
        }

        if (gameState.unitsState
            .where(
              (element) => element.location == b,
            )
            .isNotEmpty) {
          return -1;
        }

        return 0;
      },
    );

    return Emulator.emulateDistance(
      currentTile: unitLocation,
      targetTile: allTargetArea.first,
    );
  }
}
