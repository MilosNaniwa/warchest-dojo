import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';

class AiEngineRandom {
  static ActionModel choiceAction({
    required List<ActionModel> actions,
    required GameStateModel gameState,
  }) {
    actions.shuffle();
    return actions.first;
  }
}
