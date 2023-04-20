import 'dart:convert';
import 'dart:math';

import 'package:warchest_dojo/Util/Util.dart';
import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/emulator.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';

class AlphaBetaSearch {
  static const Duration _timeLimit = Duration(seconds: 10);

  // Transposition table to store previously evaluated game states
  static final Map<String, Map<int, double>> _transpositionTable = {};

  static final Map<String, double> _evaluationCache = {};

  // Function to generate a unique hash for a given game state
  static String _hashGameState(GameStateModel state) {
    final List<int> quantized = Util.quantizeGameState(gameState: state);
    final json = jsonEncode(quantized);
    return json;
  }

  static ActionModel findBestAction({
    required GameStateModel state,
    required String player,
    required String opponent,
  }) {
    final legalMoves = RuleEngine.listUpAllActions(gameState: state);
    double bestValue = double.negativeInfinity;
    Stopwatch stopwatch = Stopwatch()..start();

    legalMoves.sort(
      (a, b) => _moveOrderingHeuristic(
        state: state,
        move: b,
        player: player,
        opponent: opponent,
        isMaximizingPlayer: true,
      ).compareTo(
        _moveOrderingHeuristic(
          state: state,
          move: a,
          player: player,
          opponent: opponent,
          isMaximizingPlayer: true,
        ),
      ),
    );

    ActionModel bestMove = legalMoves.first;
    GameStateModel tmpState = _applyMove(state: state, move: bestMove);
    String bestMoveTextLog = tmpState.textLog;

    for (int currentMaxDepth = 1; currentMaxDepth <= 10; currentMaxDepth++) {
      print(
        "探索深度: ${currentMaxDepth - 1}\n"
        "現状最前案: $bestMoveTextLog\n"
        "現状評価値: $bestValue\n"
        "経過時間: ${stopwatch.elapsed}\n",
      );

      ActionModel bestMoveOfCurrentDepth = legalMoves.first;
      String bestMoveTextLogOfCurrentDepth = tmpState.textLog;
      double bestValueOfCurrentDepth = double.negativeInfinity;

      for (ActionModel move in legalMoves) {
        GameStateModel nextState = _applyMove(state: state, move: move);
        double value = _alphaBetaAspiration(
          state: nextState,
          depth: 1,
          alpha: double.negativeInfinity,
          beta: double.infinity,
          isMaximizingPlayer: nextState.turn == player ? true : false,
          stopwatch: stopwatch,
          player: player,
          opponent: opponent,
          maxDepth: currentMaxDepth,
        );

        if (value > bestValueOfCurrentDepth) {
          print(
            "更新\n"
            "直前案: $bestMoveTextLogOfCurrentDepth\n"
            "直前評価値: $bestValueOfCurrentDepth\n"
            "現状最前案: ${nextState.textLog}\n"
            "現状評価値: $value\n"
            "現在深度: $currentMaxDepth\n"
            "経過時間: ${stopwatch.elapsed}\n",
          );
          bestValueOfCurrentDepth = value;
          bestMoveOfCurrentDepth = move;
          bestMoveTextLogOfCurrentDepth = nextState.textLog;
        }
      }

      if (bestValueOfCurrentDepth > bestValue) {
        bestValue = bestValueOfCurrentDepth;
        bestMove = bestMoveOfCurrentDepth;
        bestMoveTextLog = bestMoveTextLogOfCurrentDepth;
      }

      if (stopwatch.elapsed > _timeLimit) {
        break;
      }
    }

    print(
      "最終探索案: $bestMoveTextLog\n"
      "最終評価値: $bestValue\n",
    );

    return bestMove;
  }

  static double _alphaBetaAspiration({
    required GameStateModel state,
    required int depth,
    required double alpha,
    required double beta,
    required bool isMaximizingPlayer,
    required Stopwatch stopwatch,
    required String player,
    required String opponent,
    required int maxDepth,
  }) {
    if (depth >= maxDepth || stopwatch.elapsed > _timeLimit) {
      return _evaluateState(
        state: state,
        player: player,
        opponent: opponent,
      );
    }

    final stateHash = _hashGameState(state);
    if (_transpositionTable.containsKey(stateHash) &&
        _transpositionTable[stateHash]!.containsKey(depth)) {
      return _transpositionTable[stateHash]![depth]!;
    }

    List<ActionModel> legalMoves = RuleEngine.listUpAllActions(gameState: state);
    if (legalMoves.isEmpty) {
      return isMaximizingPlayer ? double.negativeInfinity : double.infinity;
    }

    if (isMaximizingPlayer) {
      legalMoves.sort(
        (a, b) => _moveOrderingHeuristic(
          state: state,
          move: b,
          player: player,
          opponent: opponent,
          isMaximizingPlayer: true,
        ).compareTo(
          _moveOrderingHeuristic(
            state: state,
            move: a,
            player: player,
            opponent: opponent,
            isMaximizingPlayer: true,
          ),
        ),
      );

      for (ActionModel move in legalMoves) {
        GameStateModel nextState = _applyMove(state: state, move: move);
        alpha = max(
          alpha,
          _alphaBetaAspiration(
            state: nextState,
            depth: depth + 1,
            alpha: alpha,
            beta: beta,
            isMaximizingPlayer: nextState.turn == player ? true : false,
            stopwatch: stopwatch,
            player: player,
            opponent: opponent,
            maxDepth: maxDepth,
          ),
        );

        if (!_transpositionTable.containsKey(stateHash)) {
          _transpositionTable[stateHash] = {};
        }
        _transpositionTable[stateHash]![depth] = alpha;

        if (alpha >= beta || stopwatch.elapsed > _timeLimit) {
          break;
        }
      }
      return alpha;
    } else {
      legalMoves.sort(
        (a, b) => _moveOrderingHeuristic(
          state: state,
          move: a,
          player: player,
          opponent: opponent,
          isMaximizingPlayer: false,
        ).compareTo(
          _moveOrderingHeuristic(
            state: state,
            move: b,
            player: player,
            opponent: opponent,
            isMaximizingPlayer: false,
          ),
        ),
      );
      for (ActionModel move in legalMoves) {
        GameStateModel nextState = _applyMove(state: state, move: move);
        beta = min(
          beta,
          _alphaBetaAspiration(
            state: nextState,
            depth: depth + 1,
            alpha: alpha,
            beta: beta,
            isMaximizingPlayer: nextState.turn == player ? true : false,
            stopwatch: stopwatch,
            player: player,
            opponent: opponent,
            maxDepth: maxDepth,
          ),
        );

        if (!_transpositionTable.containsKey(stateHash)) {
          _transpositionTable[stateHash] = {};
        }
        _transpositionTable[stateHash]![depth] = beta;

        if (alpha >= beta || stopwatch.elapsed > _timeLimit) {
          break;
        }
      }
      return beta;
    }
  }

  static double _moveOrderingHeuristic({
    required GameStateModel state,
    required ActionModel move,
    required String player,
    required String opponent,
    required bool isMaximizingPlayer,
  }) {
    // Implement a heuristic function to order moves based on their potential strength
    // Return a higher value for moves that seem more promising
    GameStateModel newState = _applyMove(state: state, move: move);
    double value = _evaluateState(
      state: newState,
      player: player,
      opponent: opponent,
    );

    double bonus = 0;

    switch (move.actionType) {
      case ActionTypeConst.takeInitiative:
        bonus += 100;
        break;
      case ActionTypeConst.dominate:
        bonus += 100;
        break;
      case ActionTypeConst.deploy:
        bonus += 90;
        break;
      case ActionTypeConst.attack:
        bonus += 80;
        break;
      case ActionTypeConst.instructionAttack:
        bonus += 80;
        break;
      case ActionTypeConst.move:
        bonus += 70;
        break;
      case ActionTypeConst.instructionMove:
        bonus += 60;
        break;
      case ActionTypeConst.recruit:
        bonus += 10;
        break;
      case ActionTypeConst.bolster:
        bonus += 10;
        break;
      default:
        break;
    }

    if (isMaximizingPlayer) {
      value += bonus;
    } else {
      value -= bonus;
    }

    return value;
  }

  static GameStateModel _applyMove({
    required GameStateModel state,
    required ActionModel move,
  }) {
    // Apply the given move to the given state and return the new state
    return RuleEngine.forwardToNextState(
      gameState: RuleEngine.executeAction(
        action: move,
        gameState: state,
      ),
    );
  }

  static double _evaluateState({
    required GameStateModel state,
    required String player,
    required String opponent,
  }) {
    final stateHash = _hashGameState(state);
    if (_evaluationCache.containsKey(stateHash)) {
      return _evaluationCache[stateHash]!;
    }

    // Evaluate the given state and return a score
    double playerScore = _evaluateControlPoint(state, player) +
        _evaluateUnits(state, player) +
        _evaluateStrength(state, player);
    double opponentScore = _evaluateControlPoint(state, opponent) +
        _evaluateUnits(state, opponent) +
        _evaluateStrength(state, opponent);

    double finalScore = playerScore - opponentScore;

    // Cache the evaluation result
    _evaluationCache[stateHash] = finalScore;

    return finalScore;
  }

  static double _evaluateControlPoint(GameStateModel state, String player) {
    final countOfDominatedControlPoint = state.controlPointsState
        .where(
          (e) => e.dominatedBy == player,
        )
        .length;

    double score = 30.0 * countOfDominatedControlPoint;

    return score;
  }

  static double _evaluateStrength(GameStateModel state, String player) {
    double score = state.unitsState
        .where(
      (e) =>
          e.team == player &&
          [
            HexagonConst.bag,
            HexagonConst.discard,
            HexagonConst.hand,
            HexagonConst.board,
          ].contains(e.layer),
    )
        .fold<double>(
      0,
      (previousValue, element) {
        double tmp = 0;
        switch (element.unitClass) {
          case UnitClassConst.lightCavalry:
            tmp += 1.1;
            break;
          case UnitClassConst.crossbow:
            tmp += 1.1;
            break;
          case UnitClassConst.cavalry:
            tmp += 1.2;
            break;
          case UnitClassConst.archer:
            tmp += 1.2;
            break;
          default:
            tmp += 1.0;
            break;
        }
        return previousValue + tmp;
      },
    );

    double bonus = state.unitsState
        .where(
      (e) =>
          e.team == player &&
          [
            HexagonConst.cemetery,
          ].contains(e.layer),
    )
        .fold<double>(
      0,
      (previousValue, element) {
        return previousValue + 10.0;
      },
    );

    score -= bonus;

    return score;
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
        .toSet()) {
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
    double score = 2;

    final distanceOfNearestRoyalLocation = _computeNearestRoyalLocationDistance(
      unitLocation: unit.location,
      player: unit.team,
      gameState: state,
    );

    if (distanceOfNearestRoyalLocation < 1) {
      score += 11;
    }

    if (distanceOfNearestRoyalLocation < 2) {
      score += 6;
    }

    if (distanceOfNearestRoyalLocation < 3) {
      score += 1;
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
            (childElement) =>
                childElement.team == player &&
                childElement.layer == HexagonConst.board &&
                childElement.location != unitLocation,
          )
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
