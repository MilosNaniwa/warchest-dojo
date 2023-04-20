part of 'play_page.dart';

Future<void> _onSelectedHandCoin({
  required BuildContext context,
  required UnitModel unitToUse,
  List<ActionModel>? actions,
  bool isInstructedAction = false,
  required GameStateModel? currentGameState,
}) async {
  final boardCubit = context.read<BoardCubit>();

  // 従兵に無関係の場合
  if (unitToUse.unitClass != UnitClassConst.footman) {
    boardCubit.displayActionable(
      gameStateModel: currentGameState!,
      unitToUse: unitToUse,
      actions: actions,
      isInstructedAction: isInstructedAction,
    );
    return;
  }

  // 使用対象が従兵の場合
  final footmanDeployedArea = currentGameState!.unitsState
      .where(
        (element) =>
            element.unitClass == UnitClassConst.footman && element.layer == HexagonConst.board,
      )
      .map(
        (e) => e.location,
      )
      .toSet()
      .toList();

  footmanDeployedArea.sort(
    (a, b) => a.compareTo(b),
  );

  if (footmanDeployedArea.isEmpty) {
    boardCubit.displayActionable(
      gameStateModel: currentGameState,
      unitToUse: unitToUse,
      actions: actions,
      isInstructedAction: isInstructedAction,
    );
    return;
  }
  if (footmanDeployedArea.length > 1) {
    final selectedLocation = currentGameState.waitingFootmanLocations.length == 1
        ? Future.value(currentGameState.waitingFootmanLocations.first)
        : showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              content: Text(PlayPageMessage.of(globalLanguageCode).whichFootmanWillMoveFirst),
              actions: footmanDeployedArea
                  .map(
                    (id) => ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(id),
                      child: Text(Util.convertTileIdToTileName(tileId: id)),
                    ),
                  )
                  .toList(),
            ),
          );

    selectedLocation.then((value) {
      if (value != null) {
        boardCubit.removeSomeActions(
          gameStateModel: currentGameState,
          actions: actions,
          removeActions: [
            ActionTypeConst.attack,
            ActionTypeConst.move,
            ActionTypeConst.dominate,
          ],
          selectedLocation: value,
          isInstructedAction: isInstructedAction,
          unitToUse: unitToUse,
        );
      } else {
        boardCubit.clearFocus();
      }
    });
  } else {
    final tmpActions = actions ??
        RuleEngine.listUpActions(
          unitToUse: unitToUse,
          gameState: currentGameState,
        );

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Text(PlayPageMessage.of(globalLanguageCode).selectYourAction),
        actions: [
          if (tmpActions.any((action) => action.actionType == ActionTypeConst.deploy))
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(ActionTypeConst.deploy),
              icon: const Icon(FontAwesomeIcons.user),
              label: Text(PlayPageMessage.of(globalLanguageCode).deployNewFootman),
            ),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(HexagonConst.maneuver),
            icon: const Icon(FontAwesomeIcons.upDownLeftRight),
            label: Text(PlayPageMessage.of(globalLanguageCode).maneuverMyFootman),
          ),
        ],
      ),
    ).then(
      (value) {
        if (value == ActionTypeConst.deploy) {
          boardCubit.removeOtherActions(
            gameStateModel: currentGameState,
            actionType: ActionTypeConst.deploy,
            unitToUse: unitToUse,
            actions: actions,
            isInstructedAction: isInstructedAction,
          );
        } else if (value != null) {
          boardCubit.removeSomeActions(
            gameStateModel: currentGameState,
            actions: actions,
            removeActions: [
              ActionTypeConst.deploy,
            ],
            selectedLocation: unitToUse.location,
            isInstructedAction: isInstructedAction,
            unitToUse: unitToUse,
          );
        } else {
          boardCubit.clearFocus();
        }
      },
    );
  }
}

// Extract the switch statement into a separate function for clarity and maintainability.
Future<void> executeActionBasedOnValue({
  required String value,
  required BuildContext context,
  required List<UnitModel> deployedUnitList,
  required String currentTileName,
  required String currentTileId,
}) async {
  final playState = context.select(
    (GameMasterCubit cubit) => cubit.state,
  );
  final boardState = context.select(
    (BoardCubit cubit) => cubit.state,
  );
  if (value != HexagonConst.focus) {
    switch (value) {
      case ActionTypeConst.move:
        context.read<GameMasterCubit>().executeAction(
              actionModel: boardState.actions.firstWhere((element) =>
                  [ActionTypeConst.move, ActionTypeConst.instructionMove]
                      .contains(element!.actionType) &&
                  element.targetLocation == currentTileId)!,
            );
        break;
      case ActionTypeConst.dominate:
        context.read<GameMasterCubit>().executeAction(
              actionModel: boardState.actions.firstWhere(
                (element) =>
                    element!.actionType == ActionTypeConst.dominate &&
                    element.targetLocation == currentTileId,
              )!,
            );
        break;
      case ActionTypeConst.bolster:
        context.read<GameMasterCubit>().executeAction(
              actionModel: boardState.actions.firstWhere(
                (element) =>
                    element!.actionType == ActionTypeConst.bolster &&
                    element.targetLocation == currentTileId,
              )!,
            );
        break;
      case ActionTypeConst.attack:
        context.read<GameMasterCubit>().executeAction(
              actionModel: boardState.actions.firstWhere((element) =>
                  [ActionTypeConst.attack, ActionTypeConst.instructionAttack]
                      .contains(element!.actionType) &&
                  element.targetLocation == currentTileId)!,
            );
        break;
      case ActionTypeConst.deploy:
        context.read<GameMasterCubit>().executeAction(
              actionModel: boardState.actions.firstWhere(
                (element) =>
                    element!.actionType == ActionTypeConst.deploy &&
                    element.targetLocation == currentTileId,
              )!,
            );
        break;
      case HexagonConst.tactical:
        _onSelectedHandCoin(
          context: context,
          unitToUse: boardState.selectedUnit!,
          actions: boardState.actions.map((e) => e!).toList(),
          currentGameState: playState.currentGameState!,
        );
        break;
      case TacticConst.oracle:
        _onSelectedHandCoin(
          context: context,
          unitToUse: boardState.selectedUnit!,
          currentGameState: playState.currentGameState!,
        );
        break;
      case HexagonConst.instruct:
        final tmpActions = (() {
          if (boardState.selectedUnit!.unitClass == UnitClassConst.marshall) {
            return boardState.actions
                .where((element) =>
                    element!.actionType == ActionTypeConst.instructionAttack &&
                    element.unitsToAction.contains(deployedUnitList.first))
                .toList();
          } else if (boardState.selectedUnit!.unitClass == UnitClassConst.ensign) {
            return boardState.actions
                .where((element) =>
                    element!.actionType == ActionTypeConst.instructionMove &&
                    element.unitsToAction
                        .map((e) => e.unitId)
                        .contains(deployedUnitList.first.unitId))
                .toList();
          }
        })();

        _onSelectedHandCoin(
          context: context,
          unitToUse: boardState.selectedUnit!,
          actions: tmpActions!.map((e) => e!).toList(),
          isInstructedAction: true,
          currentGameState: playState.currentGameState!,
        );
        break;
      default:
        break;
    }
  } else {
    context.read<BoardCubit>().clearFocus();
    context.read<BoardCubit>().focusTile(
          tileId: currentTileId,
        );
  }
}

void _playStateListener(
  BuildContext context,
  GameMasterState state, {
  required String difficulty,
  required int aiThinkingTime,
}) {
  switch (state.status) {
    case GameMasterStatus.initial:
    case GameMasterStatus.initializeInProgress:
      break;
    case GameMasterStatus.initializeSuccess:
      if (globalChatMode) {
        context.read<ChatCubit>().greeting();
      }

      if (state.currentGameState!.turn == HexagonConst.playerBlue && !state.isAiBluePlayer) {
        break;
      }

      final aiEngineBloc = context.read<AIEngineCubit>();

      if (difficulty == HexagonConst.prototype) {
        aiEngineBloc.fetchBestActionFromCloud(
          gameStateModel: state.currentGameState!,
          gameMatchId: state.gameMatchId,
        );
        break;
      }

      aiEngineBloc.findBestAction(
        gameStateModel: state.currentGameState!,
        difficulty: difficulty,
        aiThinkingTime: aiThinkingTime,
      );
      break;
    case GameMasterStatus.executeActionSuccess:
      context.read<BoardCubit>().clearFocus();

      if (state.currentGameState!.hasGameFinished == true) {
        if (globalChatMode) {
          context.read<ChatCubit>().farewell(
                winner: state.currentGameState!.winner,
              );
        }

        _executeGameEndProcess(
          context: context,
          winner: state.currentGameState!.winner,
          difficulty: difficulty,
        );
        break;
      }

      if (globalChatMode) {
        if (state.currentGameState!.snapshotId % 4 == 0) {
          context.read<ChatCubit>().fetchNpcResponse(
                countOfBlueControlPoint: state.currentGameState!.controlPointsState
                    .where(
                      (element) => element.dominatedBy == HexagonConst.playerBlue,
                    )
                    .length,
                countOfRedControlPoint: state.currentGameState!.controlPointsState
                    .where(
                      (element) => element.dominatedBy == HexagonConst.playerRed,
                    )
                    .length,
                textLog: state.textLog.map((e) => e!).toList(),
              );
        }
      }

      if (state.currentGameState!.turn == HexagonConst.playerBlue && !state.isAiBluePlayer) {
        if (state.currentGameState!.allowedActionTypes.any(
          (element) => [
            TacticConst.endurance,
            TacticConst.berserk,
            TacticConst.oracle,
            TacticConst.haste,
            TacticConst.immediateForce,
            TacticConst.teamwork,
          ].contains(element),
        )) {
          final additionalActions = RuleEngine.listUpTacticAction(
            gameState: state.currentGameState!,
          );
          _onSelectedHandCoin(
            context: context,
            unitToUse: additionalActions.first.unitToUse,
            actions: additionalActions,
            currentGameState: state.currentGameState!,
          );
        }
        break;
      }

      final aiEngineBloc = context.read<AIEngineCubit>();

      if (difficulty == HexagonConst.prototype) {
        aiEngineBloc.fetchBestActionFromCloud(
          gameStateModel: state.currentGameState!,
          gameMatchId: state.gameMatchId,
        );
        break;
      }

      aiEngineBloc.findBestAction(
        gameStateModel: state.currentGameState!,
        difficulty: difficulty,
        aiThinkingTime: aiThinkingTime,
      );
      break;
    case GameMasterStatus.executeActionInProgress:
      break;
  }
}

void _executeGameEndProcess({
  required BuildContext context,
  required String winner,
  required String difficulty,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            PlayPageMessage.of(globalLanguageCode).playerOrComputerHasWon.replaceAll(
                  "{team}",
                  Util.convertTeamIdToTeamName(
                    team: winner,
                  ),
                ),
          ),
          if (globalChatMode == true && difficulty != "chief" && winner == HexagonConst.playerBlue)
            Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset(
                    'assets/character/alisha_full_${Random().nextInt(5) + 1}.png',
                  ),
                ),
                Text(
                  "Congratulations!",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            PlayPageMessage.of(globalLanguageCode).thankYou,
          ),
        ),
      ],
    ),
  );
  context.read<GameMasterCubit>().recordGameLog(
        difficulty: difficulty,
      );
}

void _aiEngineStateListener(BuildContext context, AIEngineState state) {
  switch (state.status) {
    case AIEngineStatus.initial:
    case AIEngineStatus.inProgress:
      break;
    case AIEngineStatus.success:
      context.read<GameMasterCubit>().executeAction(
            actionModel: state.selectedAction!,
          );
      break;
  }
}
