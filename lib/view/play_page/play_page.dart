import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:warchest_dojo/const/action_type_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/tactic_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/game_engine/rule_engine.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/play_page_message.dart';
import 'package:warchest_dojo/localization/title_page_message.dart';
import 'package:warchest_dojo/model/action_model.dart';
import 'package:warchest_dojo/model/game_state_model.dart';
import 'package:warchest_dojo/model/unit_model.dart';
import 'package:warchest_dojo/service/ai_engine/ai_engine_cubit.dart';
import 'package:warchest_dojo/service/ai_engine/ai_engine_state.dart';
import 'package:warchest_dojo/service/board/board_cubit.dart';
import 'package:warchest_dojo/service/chat/chat_cubit.dart';
import 'package:warchest_dojo/service/chat/chat_state.dart';
import 'package:warchest_dojo/service/game_master/game_master_cubit.dart';
import 'package:warchest_dojo/service/game_master/game_master_state.dart';
import 'package:warchest_dojo/util/util.dart';
import 'package:warchest_dojo/widget/hexagon_grid.dart';
import 'package:warchest_dojo/widget/hexagon_tile.dart';
import 'package:warchest_dojo/widget/stateful_wrapper.dart';
import 'package:warchest_dojo/widget/unit_coin.dart';

part 'play_page_function.dart';

const double coinSize = 48;
final int aiThinkingTime = globalChatMode ? 3500 : 1500;

const double baseHeight = 640;
const double baseWidth = 1440;

class PlayPage extends StatelessWidget {
  final List<String> playerUnitList;
  final List<String> aiUnitList;
  final String difficulty;
  final bool aiMode;

  const PlayPage({
    Key? key,
    required this.playerUnitList,
    required this.aiUnitList,
    required this.difficulty,
    this.aiMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => GameMasterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => BoardCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ChatCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AIEngineCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<GameMasterCubit, GameMasterState>(
            listener: (context, state) => _playStateListener(
              context,
              state,
              difficulty: difficulty,
              aiThinkingTime: aiThinkingTime,
            ),
          ),
          const BlocListener<AIEngineCubit, AIEngineState>(
            listener: _aiEngineStateListener,
          ),
        ],
        child: PlayPageView(
          playerUnitList: playerUnitList,
          aiUnitList: aiUnitList,
          difficulty: difficulty,
        ),
      ),
    );
  }
}

class PlayPageView extends StatelessWidget {
  final List<String> playerUnitList;
  final List<String> aiUnitList;
  final String difficulty;
  final bool aiMode;

  const PlayPageView({
    Key? key,
    required this.playerUnitList,
    required this.aiUnitList,
    required this.difficulty,
    this.aiMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playStateStatus = context.select(
      (GameMasterCubit cubit) => cubit.state.status,
    );

    final chatStatus = context.select(
      (ChatCubit cubit) => cubit.state.status,
    );
    final chatBotMessage = context.select(
      (ChatCubit cubit) => cubit.state.chatBotMessage,
    );

    final turn = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState == null
          ? HexagonConst.playerBlue
          : cubit.state.currentGameState!.turn,
    );

    final hasGameFinished = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState == null
          ? false
          : cubit.state.currentGameState!.hasGameFinished,
    );

    return StatefulWrapper(
      onInit: () {
        context.read<GameMasterCubit>().initialize(
              aiMode: aiMode,
              playerUnitList: playerUnitList,
              aiUnitList: aiUnitList,
              difficulty: difficulty,
            );
      },
      child: Builder(builder: (context) {
        if ([
          GameMasterStatus.initial,
          GameMasterStatus.initializeInProgress,
        ].contains(playStateStatus)) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              PlayPageMessage.of(globalLanguageCode).warChestDojo,
            ),
          ),
          body: InteractiveViewer(
            constrained: false,
            maxScale: 2.0,
            minScale: 0.001,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 64),
                        child: Column(
                          children: [
                            const _ScoreText(),
                            const _BattleField(
                              executeActionBasedOnValue: executeActionBasedOnValue,
                            ),
                            Row(
                              children: [
                                const _CurrentTurnText(),
                                const SizedBox(
                                  width: 16,
                                ),
                                turn == HexagonConst.playerBlue || hasGameFinished == true
                                    ? const SizedBox.shrink()
                                    : ThinkingIndicator(
                                        millisecond: aiThinkingTime,
                                      ),
                              ],
                            ),
                            const _LastTurnTextLogArea(),
                            if (globalChatMode)
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  width: baseWidth * 0.4,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: Image.asset(
                                          'assets/character/alisha.png',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Flexible(
                                        child: chatStatus == ChatStatus.inProgress
                                            ? const Text('...')
                                            : TypewriterText(text: chatBotMessage),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            _GameFinishedArea(
                              aiMode: aiMode,
                              playerUnitList: playerUnitList,
                              aiUnitList: aiUnitList,
                              difficulty: difficulty,
                            ),
                          ],
                        ),
                      ),
                      // 赤軍
                      Column(
                        children: [
                          _RedTeamArea(
                            aiUnitList: aiUnitList,
                            onTap: _onSelectedHandCoin,
                          ),
                          _InformationArea(
                            aiMode: aiMode,
                            playerUnitList: playerUnitList,
                            aiUnitList: aiUnitList,
                            difficulty: difficulty,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // 青軍
                  _BlueTeamArea(
                    playerUnitList: playerUnitList,
                    coinSize: coinSize,
                    onTap: _onSelectedHandCoin,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _InformationArea extends StatelessWidget {
  const _InformationArea({
    required this.aiMode,
    required this.playerUnitList,
    required this.aiUnitList,
    required this.difficulty,
  });

  final bool aiMode;
  final List<String> playerUnitList;
  final List<String> aiUnitList;
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: baseWidth * 0.3,
      child: Row(
        children: [
          Spacer(),
          Column(
            children: [
              SizedBox(
                height: 16,
              ),
              _TextLogArea(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreText extends StatelessWidget {
  const _ScoreText();

  @override
  Widget build(BuildContext context) {
    final controlPointsState = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.controlPointsState,
    );

    return Text(
      "${PlayPageMessage.of(globalLanguageCode).player} ${controlPointsState.where(
            (element) => element.dominatedBy == HexagonConst.playerBlue,
          ).length} - ${controlPointsState.where(
            (element) => element.dominatedBy == HexagonConst.playerRed,
          ).length} ${PlayPageMessage.of(globalLanguageCode).computer}",
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class _CurrentTurnText extends StatelessWidget {
  const _CurrentTurnText();

  @override
  Widget build(BuildContext context) {
    final winner = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.winner,
    );
    final turn = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.turn,
    );

    return Visibility(
      visible: winner.isEmpty,
      child: Text(
        turn == HexagonConst.playerBlue
            ? PlayPageMessage.of(globalLanguageCode).yourTurn
            : PlayPageMessage.of(globalLanguageCode).aiIsThinking,
        style: TextStyle(
          fontSize: 20,
          color: turn == HexagonConst.playerBlue ? Colors.blueAccent : Colors.redAccent,
        ),
      ),
    );
  }
}

class _GameFinishedArea extends StatelessWidget {
  const _GameFinishedArea({
    required this.aiMode,
    required this.playerUnitList,
    required this.aiUnitList,
    required this.difficulty,
  });

  final bool aiMode;
  final List<String> playerUnitList;
  final List<String> aiUnitList;
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    final winner = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.winner,
    );

    return Visibility(
      visible: winner.isNotEmpty,
      child: Column(
        children: [
          Text(
            PlayPageMessage.of(globalLanguageCode).wantToRematch,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<GameMasterCubit>().initialize(
                      aiMode: aiMode,
                      playerUnitList: playerUnitList,
                      aiUnitList: aiUnitList,
                      difficulty: difficulty,
                    );
              },
              icon: Icon(
                FontAwesomeIcons.rotate,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: Text(
                PlayPageMessage.of(globalLanguageCode).rematch,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                launchUrlString(
                  "https://www.buymeacoffee.com/milosnaniwa",
                );
              },
              icon: Icon(
                FontAwesomeIcons.mugSaucer,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: Text(
                PlayPageMessage.of(globalLanguageCode).supportCreator,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                launchUrlString(
                  TitlePageMessage.of(globalLanguageCode).feedbackUrl,
                );
              },
              icon: Icon(
                FontAwesomeIcons.comment,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: Text(
                TitlePageMessage.of(globalLanguageCode).feedback,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextLogArea extends StatelessWidget {
  const _TextLogArea();

  @override
  Widget build(BuildContext context) {
    final state = context.select(
      (GameMasterCubit cubit) => cubit.state,
    );

    return SizedBox(
      width: baseWidth * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: state.textLog
            .take(5)
            .map(
              (text) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  text!,
                  style: TextStyle(
                    color: state.textLog.indexOf(text) < 1
                        ? Colors.black87
                        : state.textLog.indexOf(text) < 4
                            ? Colors.black54
                            : Colors.black26,
                    fontSize: baseWidth * 0.01 > 14 ? baseWidth * 0.01 : 14,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LastTurnTextLogArea extends StatelessWidget {
  const _LastTurnTextLogArea();

  @override
  Widget build(BuildContext context) {
    final state = context.select(
      (GameMasterCubit cubit) => cubit.state,
    );

    return Text(
      state.textLog.first!,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: baseWidth * 0.01 > 14 ? baseWidth * 0.01 : 14,
      ),
    );
  }
}

class _BattleField extends StatelessWidget {
  const _BattleField({
    required this.executeActionBasedOnValue,
  });

  final Function({
    required String value,
    required BuildContext context,
    required List<UnitModel> deployedUnitList,
    required String currentTileName,
    required String currentTileId,
  }) executeActionBasedOnValue;

  @override
  Widget build(BuildContext context) {
    final playState = context.watch<GameMasterCubit>().state;
    final boardState = context.watch<BoardCubit>().state;

    return SizedBox(
      height: 480,
      width: 480,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ColoredBox(
              color: Colors.transparent,
              child: HexagonGrid(
                screenWidth: constraints.maxWidth,
                screenHeight: constraints.maxHeight,
                reversed: boardState.reversed,
                builder: (
                  int coordinateX,
                  int coordinateY,
                  Offset centerOffset,
                  double radius,
                ) {
                  final currentTileId = boardState.reversed
                      ? "${6 - coordinateX}–${coordinateX % 2 == 1 ? 6 - coordinateY : 7 - coordinateY}"
                      : "$coordinateX–$coordinateY";
                  final currentTileName = Util.convertCoordinateToTileName(
                    coordinateX: boardState.reversed ? 6 - coordinateX : coordinateX,
                    coordinateY: boardState.reversed
                        ? coordinateX % 2 == 1
                            ? 6 - coordinateY
                            : 7 - coordinateY
                        : coordinateY,
                  );

                  final isControlPoint = playState.currentGameState!.controlPointsState
                          .where(
                            (element) => element.tileId == currentTileId,
                          )
                          .isNotEmpty ==
                      true;

                  final deployedUnitList = playState.currentGameState!.unitsState
                      .where(
                        (element) => element.location == currentTileId,
                      )
                      .toList();

                  if (deployedUnitList.isEmpty) {
                    deployedUnitList.add(
                      const UnitModel(
                        unitId: UnitClassConst.none,
                        unitClass: UnitClassConst.none,
                        team: HexagonConst.neutral,
                        location: HexagonConst.none,
                        layer: UnitClassConst.none,
                        shouldHide: false,
                      ),
                    );
                  }

                  return HexagonTile(
                    tileName:
                        // currentTileId,
                        currentTileName,
                    coordinateX: coordinateX,
                    coordinateY: coordinateY,
                    centerOffset: centerOffset,
                    radius: radius,
                    hitPoint: deployedUnitList.length,
                    isFocused: boardState.focusedTileId == currentTileId,
                    isHovered: boardState.hovered == currentTileId,
                    deployedUnitClass: deployedUnitList.first.unitClass,
                    isOpponentUnit: deployedUnitList.first.team != HexagonConst.playerBlue,
                    isMovable: boardState.movableList.contains(
                          currentTileId,
                        ) ==
                        true,
                    isAttackable: boardState.attackableList.contains(
                          currentTileId,
                        ) ==
                        true,
                    isDeployable: boardState.deployableList.contains(currentTileId) == true,
                    isInstructable: boardState.instructableList.contains(currentTileId) == true,
                    isControlPoint: playState.currentGameState!.controlPointsState
                            .where(
                              (element) => element.tileId == currentTileId,
                            )
                            .isNotEmpty ==
                        true,
                    dominatedBy: isControlPoint == true
                        ? playState.currentGameState!.controlPointsState
                            .firstWhere(
                              (element) => element.tileId == currentTileId,
                            )
                            .dominatedBy
                        : HexagonConst.neutral,
                    onTap: playState.currentGameState!.hasGameFinished == true
                        ? null
                        : () async {
                            final action = () async {
                              if (boardState.selectedUnit!.unitClass == UnitClassConst.none) {
                                if (deployedUnitList.first.unitClass != UnitClassConst.none) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(
                                        PlayPageMessage.of(globalLanguageCode)
                                            .pleaseSelectHandFirst,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text(
                                            PlayPageMessage.of(globalLanguageCode).understood,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return HexagonConst.focus;
                              }

                              if (boardState.deployableList.contains(currentTileId)) {
                                return ActionTypeConst.deploy;
                              }

                              if (boardState.attackableList.contains(currentTileId)) {
                                return ActionTypeConst.attack;
                              }

                              if (boardState.movableList.contains(currentTileId)) {
                                return ActionTypeConst.move;
                              }

                              if (boardState.bolsterableList.contains(currentTileId)) {
                                if (boardState.dominatableList.contains(currentTileId)) {
                                  final action = await showDialog<String>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(
                                        PlayPageMessage.of(globalLanguageCode).selectYourAction,
                                      ),
                                      actions: [
                                        ElevatedButton.icon(
                                          onPressed: () =>
                                              Navigator.of(context).pop(ActionTypeConst.bolster),
                                          icon: const Icon(FontAwesomeIcons.userPlus),
                                          label:
                                              Text(PlayPageMessage.of(globalLanguageCode).bolster),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () =>
                                              Navigator.of(context).pop(ActionTypeConst.dominate),
                                          icon: const Icon(FontAwesomeIcons.flag),
                                          label:
                                              Text(PlayPageMessage.of(globalLanguageCode).dominate),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (action == ActionTypeConst.dominate) {
                                    return ActionTypeConst.dominate;
                                  } else if (action == ActionTypeConst.bolster) {
                                    return ActionTypeConst.bolster;
                                  }
                                } else {
                                  return ActionTypeConst.bolster;
                                }
                              }

                              if (boardState.dominatableList.contains(currentTileId)) {
                                return ActionTypeConst.dominate;
                              }

                              if (boardState.instructableList.contains(currentTileId)) {
                                return HexagonConst.instruct;
                              }

                              if (playState.currentGameState!.allowedActionTypes.any((element) => [
                                    TacticConst.endurance,
                                    TacticConst.berserk,
                                    TacticConst.haste,
                                    TacticConst.immediateForce,
                                    TacticConst.teamwork
                                  ].contains(element))) {
                                return HexagonConst.tactical;
                              }

                              if (playState.currentGameState!.allowedActionTypes
                                  .any((element) => [TacticConst.oracle].contains(element))) {
                                return TacticConst.oracle;
                              }

                              return HexagonConst.focus;
                            }();

                            action.then(
                              (value) => executeActionBasedOnValue(
                                value: value,
                                context: context,
                                deployedUnitList: deployedUnitList,
                                currentTileName: currentTileName,
                                currentTileId: currentTileId,
                              ),
                            );
                          },
                    onHover: (value) {
                      context.read<BoardCubit>().changeHoverTile(
                            tileId: value == true ? currentTileId : '',
                          );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RedTeamArea extends StatelessWidget {
  const _RedTeamArea({
    required this.aiUnitList,
    required this.onTap,
  });

  final List<String> aiUnitList;
  final Function({
    required BuildContext context,
    required UnitModel unitToUse,
    required GameStateModel currentGameState,
  }) onTap;

  @override
  Widget build(BuildContext context) {
    final unitsState = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.unitsState,
    );
    final redTeamDiscardToggle = context.select(
      (BoardCubit cubit) => cubit.state.redTeamDiscardToggle,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [
                  Colors.red[800]!,
                ],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 1,
              labels: [
                PlayPageMessage.of(globalLanguageCode).hand,
              ],
              radiusStyle: true,
              onToggle: null,
            ),
            Row(
              children: List.generate(
                5,
                (index) => _HandWidget(
                  unitModel: unitsState.firstWhere(
                    (element) =>
                        element.team == HexagonConst.playerRed &&
                        element.location == '${HexagonConst.hand}${index + 1}',
                    orElse: () => const UnitModel(
                      unitId: UnitClassConst.none,
                      unitClass: UnitClassConst.none,
                      team: HexagonConst.neutral,
                      location: HexagonConst.none,
                      layer: UnitClassConst.none,
                      shouldHide: false,
                    ),
                  ),
                  team: HexagonConst.playerRed,
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [
                  Colors.orange[800]!,
                ],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 1,
              labels: [
                PlayPageMessage.of(globalLanguageCode).supply,
              ],
              radiusStyle: true,
              onToggle: null,
            ),
            Column(
              children: [
                Row(
                  children: List.generate(
                    2,
                    (index) => _SupplyWidget(
                      index: index + 1,
                      unitClassList: aiUnitList,
                      coinSize: coinSize,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    2,
                    (index) => _SupplyWidget(
                      index: index + 3,
                      unitClassList: aiUnitList,
                      coinSize: coinSize,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [Colors.green[800]!],
                [Colors.red[800]!],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: redTeamDiscardToggle,
              totalSwitches: 2,
              labels: [
                PlayPageMessage.of(globalLanguageCode).discard,
                PlayPageMessage.of(globalLanguageCode).cemetery,
              ],
              radiusStyle: true,
              onToggle: (index) {
                context.read<BoardCubit>().changeRedTeamToggle(
                      index: index ?? 0,
                    );
              },
            ),

            // 捨て場
            Stack(
              children: [
                Visibility(
                  visible: redTeamDiscardToggle == 0,
                  child: Row(
                    children: List.generate(
                      aiUnitList.length + 1,
                      (index) => _DiscardWidget(
                        index: index,
                        team: HexagonConst.playerRed,
                        unitClassList: aiUnitList,
                        discardUnitList: index > 4
                            ? unitsState
                                .where(
                                  (element) =>
                                      element.team == HexagonConst.playerRed &&
                                      element.location == HexagonConst.discard &&
                                      element.shouldHide == true,
                                )
                                .toList()
                            : unitsState
                                .where(
                                  (element) =>
                                      element.unitClass == aiUnitList[index] &&
                                      element.location == HexagonConst.discard &&
                                      element.shouldHide == false,
                                )
                                .toList(),
                      ),
                    ),
                  ),
                ),

                // 墓場
                Visibility(
                  visible: redTeamDiscardToggle == 1,
                  child: Row(
                    children: List.generate(
                      aiUnitList.length,
                      (index) => _CemeteryWidget(
                        index: index,
                        unitClassList: aiUnitList,
                        cemeteryUnitList: unitsState
                            .where(
                              (element) =>
                                  element.unitClass == aiUnitList[index] &&
                                  element.location == HexagonConst.cemetery,
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _BlueTeamArea extends StatelessWidget {
  const _BlueTeamArea({
    required this.playerUnitList,
    required this.coinSize,
    required this.onTap,
  });

  final List<String> playerUnitList;
  final double coinSize;
  final Function({
    required BuildContext context,
    required UnitModel unitToUse,
    required GameStateModel currentGameState,
  }) onTap;

  @override
  Widget build(BuildContext context) {
    final actions = context.select(
      (BoardCubit cubit) => cubit.state.actions,
    );
    final unitsState = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState!.unitsState,
    );
    final blueTeamDiscardToggle = context.select(
      (BoardCubit cubit) => cubit.state.blueTeamDiscardToggle,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 40,
              width: 160,
              child: ElevatedButton.icon(
                onPressed: actions
                        .where(
                          (element) => element!.actionType == ActionTypeConst.pass,
                        )
                        .isEmpty
                    ? null
                    : () {
                        context.read<GameMasterCubit>().executeAction(
                              actionModel: actions.firstWhere(
                                (element) => element!.actionType == ActionTypeConst.pass,
                              )!,
                            );
                      },
                icon: const Icon(
                  FontAwesomeIcons.forward,
                ),
                label: Text(
                  PlayPageMessage.of(globalLanguageCode).pass,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              width: 160,
              child: ElevatedButton.icon(
                onPressed: actions
                        .where(
                          (element) => element!.actionType == ActionTypeConst.takeInitiative,
                        )
                        .isEmpty
                    ? null
                    : () {
                        context.read<GameMasterCubit>().executeAction(
                              actionModel: actions.firstWhere(
                                (element) => element!.actionType == ActionTypeConst.takeInitiative,
                              )!,
                            );
                      },
                icon: const Icon(
                  FontAwesomeIcons.rightLeft,
                ),
                label: FittedBox(
                  child: Text(
                    PlayPageMessage.of(globalLanguageCode).takeInitiative,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 32,
        ),
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [
                  Colors.blue[800]!,
                ],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 1,
              labels: [
                PlayPageMessage.of(globalLanguageCode).hand,
              ],
              radiusStyle: true,
              onToggle: null,
            ),
            Row(
              children: List.generate(
                5,
                (index) => _HandWidget(
                  unitModel: unitsState.firstWhere(
                    (element) =>
                        element.team == HexagonConst.playerBlue &&
                        element.location == '${HexagonConst.hand}${index + 1}',
                    orElse: () => const UnitModel(
                      unitId: UnitClassConst.none,
                      unitClass: UnitClassConst.none,
                      team: HexagonConst.neutral,
                      location: HexagonConst.none,
                      layer: UnitClassConst.none,
                      shouldHide: false,
                    ),
                  ),
                  team: HexagonConst.playerBlue,
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 32,
        ),
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [
                  Colors.orange[800]!,
                ],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 1,
              labels: [
                PlayPageMessage.of(globalLanguageCode).supply,
              ],
              radiusStyle: true,
              onToggle: null,
            ),
            Column(
              children: [
                Row(
                  children: List.generate(
                    2,
                    (index) => _SupplyWidget(
                      index: index + 1,
                      unitClassList: playerUnitList,
                      coinSize: coinSize,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    2,
                    (index) => _SupplyWidget(
                      index: index + 3,
                      unitClassList: playerUnitList,
                      coinSize: coinSize,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 32,
        ),
        Column(
          children: [
            ToggleSwitch(
              minWidth: 120,
              minHeight: 28,
              cornerRadius: 16.0,
              activeBgColors: [
                [Colors.green[800]!],
                [Colors.red[800]!],
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: blueTeamDiscardToggle,
              totalSwitches: 2,
              labels: [
                PlayPageMessage.of(globalLanguageCode).discard,
                PlayPageMessage.of(globalLanguageCode).cemetery,
              ],
              radiusStyle: true,
              onToggle: (index) {
                context.read<BoardCubit>().changeBlueTeamToggle(
                      index: index ?? 0,
                    );
              },
            ),

            // 捨て場
            Stack(
              children: [
                Visibility(
                  visible: blueTeamDiscardToggle == 0,
                  child: Row(
                    children: List.generate(
                      playerUnitList.length + 1,
                      (index) => _DiscardWidget(
                        index: index,
                        team: HexagonConst.playerBlue,
                        unitClassList: playerUnitList,
                        discardUnitList: index > 4
                            ? unitsState
                                .where(
                                  (element) =>
                                      element.team == HexagonConst.playerBlue &&
                                      element.location == HexagonConst.discard &&
                                      element.shouldHide == true,
                                )
                                .toList()
                            : unitsState
                                .where(
                                  (element) =>
                                      element.unitClass == playerUnitList[index] &&
                                      element.location == HexagonConst.discard &&
                                      element.shouldHide == false,
                                )
                                .toList(),
                      ),
                    ),
                  ),
                ),

                // 墓場
                Visibility(
                  visible: blueTeamDiscardToggle == 1,
                  child: Row(
                    children: List.generate(
                      playerUnitList.length,
                      (index) => _CemeteryWidget(
                        index: index,
                        unitClassList: playerUnitList,
                        cemeteryUnitList: unitsState
                            .where(
                              (element) =>
                                  element.unitClass == playerUnitList[index] &&
                                  element.location == HexagonConst.cemetery,
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SupplyWidget extends StatelessWidget {
  const _SupplyWidget({
    required this.index,
    required this.unitClassList,
    required this.coinSize,
  });

  final int index;
  final List<String> unitClassList;
  final double coinSize;

  @override
  Widget build(BuildContext context) {
    final actions = context.select(
      (BoardCubit cubit) => cubit.state.actions,
    );
    final gameState = context.select(
      (GameMasterCubit cubit) => cubit.state.currentGameState,
    );
    final selectedUnit = context.select(
      (BoardCubit cubit) => cubit.state.selectedUnit,
    );

    final unitClass = unitClassList[index];
    final supplyCount = gameState!.unitsState
        .where(
          (unit) => unit.unitClass == unitClass && unit.location == HexagonConst.supply,
        )
        .length;

    final canRecruit = selectedUnit!.unitId != UnitClassConst.none &&
        gameState.allowedActionTypes.contains(ActionTypeConst.recruit);

    return Visibility(
      visible: ![UnitClassConst.blueRoyal, UnitClassConst.redRoyal].contains(unitClass),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: canRecruit
                  ? () => _onRecruitTap(context, actions, selectedUnit, unitClass)
                  : null,
              child: UnitCoinContainer(
                unitClass: unitClass,
                size: coinSize,
                shouldHide: false,
                isSelected: false,
              ),
            ),
            const SizedBox(width: 4.0),
            Text(supplyCount.toString()),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(Util.convertUnitClassToUnitName(unitClass: unitClass)),
            ),
          ],
        ),
      ),
    );
  }

  void _onRecruitTap(
    BuildContext context,
    List<ActionModel?> actions,
    UnitModel selectedUnit,
    String unitClass,
  ) {
    final recruitActionList = actions
        .where(
          (action) =>
              action!.actionType == ActionTypeConst.recruit &&
              action.unitToUse.unitId == selectedUnit.unitId &&
              action.unitsToAction.first.unitClass == unitClass,
        )
        .toList();

    if (recruitActionList.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(PlayPageMessage.of(globalLanguageCode).thereIsNoUnitToRecruit),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(PlayPageMessage.of(globalLanguageCode).understood),
            ),
          ],
        ),
      );
    } else {
      context.read<GameMasterCubit>().executeAction(
            actionModel: recruitActionList.first!,
          );
    }
  }
}

class _HandWidget extends StatelessWidget {
  const _HandWidget({
    required this.unitModel,
    required this.team,
    required this.onTap,
  });

  final UnitModel unitModel;
  final String team;
  final Function({
    required BuildContext context,
    required UnitModel unitToUse,
    required GameStateModel currentGameState,
  }) onTap;

  @override
  Widget build(BuildContext context) {
    final playState = context.watch<GameMasterCubit>().state;
    final boardState = context.watch<BoardCubit>().state;
    final currentGameState = playState.currentGameState!;

    if (unitModel.unitClass == UnitClassConst.none) {
      return const SizedBox(
        height: coinSize,
        width: 0,
      );
    }

    final canTap = team != HexagonConst.playerRed &&
        currentGameState.turn == HexagonConst.playerBlue &&
        !playState.isAiBluePlayer &&
        currentGameState.allowedActionTypes.isNotEmpty &&
        !currentGameState.allowedActionTypes.any(
          (element) => [
            TacticConst.teamwork,
            TacticConst.endurance,
            TacticConst.berserk,
            TacticConst.haste,
            TacticConst.immediateForce,
          ].contains(element),
        ) &&
        currentGameState.winner.isEmpty;

    return Visibility(
      visible: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: canTap
              ? () => onTap(
                    context: context,
                    unitToUse: unitModel,
                    currentGameState: currentGameState,
                  )
              : null,
          child: UnitCoinContainer(
            unitClass: unitModel.unitClass,
            size: coinSize,
            shouldHide: team == HexagonConst.playerRed,
            isSelected: unitModel.unitId == boardState.selectedUnit?.unitId,
          ),
        ),
      ),
    );
  }
}

class _DiscardWidget extends StatelessWidget {
  const _DiscardWidget({
    required this.index,
    required this.team,
    required this.unitClassList,
    required this.discardUnitList,
  });

  final int index;
  final String team;
  final List<String> unitClassList;
  final List<UnitModel> discardUnitList;

  @override
  Widget build(BuildContext context) {
    if (discardUnitList.isEmpty) {
      return const SizedBox(height: coinSize);
    }

    final shouldHide = index > 4;
    final visible = discardUnitList.isNotEmpty;

    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            UnitCoinContainer(
              unitClass: shouldHide ? HexagonConst.none : unitClassList[index],
              size: coinSize,
              shouldHide: shouldHide,
              isSelected: false,
            ),
            const SizedBox(width: 4.0),
            Text(discardUnitList.length.toString()),
          ],
        ),
      ),
    );
  }
}

class _CemeteryWidget extends StatelessWidget {
  const _CemeteryWidget({
    required this.index,
    required this.unitClassList,
    required this.cemeteryUnitList,
  });

  final int index;
  final List<String> unitClassList;
  final List<UnitModel> cemeteryUnitList;

  @override
  Widget build(BuildContext context) {
    if (cemeteryUnitList.isEmpty) {
      return const SizedBox(
        height: coinSize,
        width: 0,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          UnitCoinContainer(
            unitClass: unitClassList[index],
            size: coinSize,
            shouldHide: false,
            isSelected: false,
          ),
          const SizedBox(width: 4.0),
          Text(cemeteryUnitList.length.toString()),
        ],
      ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  const TypewriterText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  TypewriterTextState createState() => TypewriterTextState();
}

class TypewriterTextState extends State<TypewriterText> with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _visibleChars = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      setState(() {
        if (_visibleChars < widget.text.length) {
          _visibleChars++;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, _visibleChars),
      style: const TextStyle(
        fontSize: baseWidth * 0.01 > 14 ? baseWidth * 0.01 : 14,
        color: Colors.black87,
      ),
    );
  }
}

class ThinkingIndicator extends StatefulWidget {
  final int millisecond;

  const ThinkingIndicator({Key? key, required this.millisecond}) : super(key: key);

  @override
  ThinkingIndicatorState createState() => ThinkingIndicatorState();
}

class ThinkingIndicatorState extends State<ThinkingIndicator> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Timer? _timer;
  double? _progress;

  @override
  void initState() {
    super.initState();
    _progress = 0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.millisecond),
    );

    _timer = Timer.periodic(Duration(microseconds: (widget.millisecond * 10).toInt()), (Timer t) {
      if (_progress! < 1) {
        setState(() {
          _progress = _progress! + 0.01; // Increase by 1% every 100 milliseconds
        });
      } else {
        t.cancel();
      }
    });

    _controller?.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: _progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ],
    );
  }
}
