import 'dart:convert';

import 'package:warchest_dojo/game_engine/alpha_beta_search.dart';
import 'package:warchest_dojo/model/game_state_model.dart';

String main(
  List<String> args,
) {
  try {
    if (args.length < 2) {
      print("呼び出し関数が指定されていません。");
      print("args: $args");
      throw Error();
    }

    final method = args[0];

    final result = () {
      switch (method) {
        case "find_best_action":
          if (args.length < 4) {
            print("引数が不足しています。");
            print("args: $args");
            throw Error();
          }
          final jsonCurrentGameState = const JsonDecoder().convert(
            args[1],
          );
          final currentGameState = GameStateModel.fromJson(
            jsonCurrentGameState,
          );
          final player = args[2];
          final opponent = args[3];

          final bestAction = AlphaBetaSearch.findBestAction(
            state: currentGameState,
            player: player,
            opponent: opponent,
          );

          return bestAction.toJson();
        default:
          print("呼び出し関数が不明です。");
          throw Error();
      }
    }();

    return const JsonEncoder().convert(result);
  } catch (e, s) {
    print(e);
    print(s);
    rethrow;
  }
}
