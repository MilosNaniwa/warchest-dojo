import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:warchest_dojo/const/environment_const.dart';
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/title_page_message.dart';
import 'package:warchest_dojo/view/draft_page.dart';
import 'package:warchest_dojo/view/play_page/play_page.dart';
import 'package:warchest_dojo/widget/unit_coin.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 4,
          ),
          Center(
            child: Text(
              TitlePageMessage.of(globalLanguageCode).titleWarChestDojo,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.075,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(
            flex: 4,
          ),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                final difficultyList = [
                  DropdownMenuItem(
                    value: HexagonConst.chief,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).chief,
                    ),
                  ),
                  DropdownMenuItem(
                    value: HexagonConst.sergeant,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).sergeant,
                    ),
                  ),
                  DropdownMenuItem(
                    value: HexagonConst.shogun,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).shogun,
                    ),
                  ),
                  DropdownMenuItem(
                    value: HexagonConst.prototype,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).prototype,
                    ),
                  ),
                ];
                String? selectedDifficulty = HexagonConst.sergeant;

                final draftModeList = [
                  DropdownMenuItem(
                    value: true,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).random,
                    ),
                  ),
                  DropdownMenuItem(
                    value: false,
                    child: Text(
                      TitlePageMessage.of(globalLanguageCode).custom,
                    ),
                  ),
                ];
                bool? selectedDraftMode = true;

                final setting = showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: StatefulBuilder(
                      builder: (context, StateSetter setState) {
                        return SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                TitlePageMessage.of(globalLanguageCode).difficulty,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropdownButton(
                                          items: difficultyList,
                                          value: selectedDifficulty,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedDifficulty = value;
                                            });
                                          },
                                        ),
                                        Visibility(
                                          visible: selectedDifficulty == HexagonConst.prototype,
                                          child: Text(
                                            TitlePageMessage.of(globalLanguageCode)
                                                .prototypeNotification,
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                TitlePageMessage.of(globalLanguageCode).draftMode,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  DropdownButton(
                                    items: draftModeList,
                                    value: selectedDraftMode,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        selectedDraftMode = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                TitlePageMessage.of(globalLanguageCode).illustrationOfUnit,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            globalKanjiMode = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            const UnitCoinContainer(
                                              unitClass: UnitClassConst.cavalry,
                                              size: 60,
                                              shouldHide: false,
                                              isSelected: false,
                                              isKanjiMode: true,
                                            ),
                                            Text(
                                              TitlePageMessage.of(globalLanguageCode).kanji,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: globalKanjiMode,
                                        child: FaIcon(
                                          FontAwesomeIcons.arrowUp,
                                          size: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            globalKanjiMode = false;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            const UnitCoinContainer(
                                              unitClass: UnitClassConst.cavalry,
                                              size: 60,
                                              shouldHide: false,
                                              isSelected: false,
                                              isKanjiMode: false,
                                            ),
                                            Text(
                                              TitlePageMessage.of(globalLanguageCode).illustration,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: !globalKanjiMode,
                                        child: FaIcon(
                                          FontAwesomeIcons.arrowUp,
                                          size: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                TitlePageMessage.of(globalLanguageCode).chatMode,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                TitlePageMessage.of(globalLanguageCode).chatModeDescription,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            globalChatMode = false;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: Icon(
                                                Icons.do_disturb_on,
                                                size: 60,
                                              ),
                                            ),
                                            Text(
                                              TitlePageMessage.of(globalLanguageCode).off,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: globalChatMode == false,
                                        child: FaIcon(
                                          FontAwesomeIcons.arrowUp,
                                          size: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 32),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            globalChatMode = true;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: Image.asset(
                                                'assets/character/alisha.png',
                                              ),
                                            ),
                                            Text(
                                              TitlePageMessage.of(globalLanguageCode).on,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: globalChatMode,
                                        child: FaIcon(
                                          FontAwesomeIcons.arrowUp,
                                          size: MediaQuery.of(context).size.height * 0.02,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          TitlePageMessage.of(globalLanguageCode).close,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop({
                          "difficulty": selectedDifficulty,
                          "draft_mode": selectedDraftMode,
                        }),
                        icon: FaIcon(
                          FontAwesomeIcons.check,
                          size: MediaQuery.of(context).size.height * 0.02,
                        ),
                        label: Text(
                          TitlePageMessage.of(globalLanguageCode).confirm,
                        ),
                      ),
                    ],
                  ),
                );

                setting.then(
                  (value) {
                    if (value != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DraftPage(
                            randomMode: value["draft_mode"],
                            difficulty: value["difficulty"],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
              icon: Icon(
                FontAwesomeIcons.chessKnight,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: FittedBox(
                child: Text(
                  TitlePageMessage.of(globalLanguageCode).startTraining,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => launchUrlString(
                "https://sponge-spatula-07e.notion.site/82a927f0fb394a50acabed6479a7ed01",
              ),
              icon: FaIcon(
                FontAwesomeIcons.book,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: FittedBox(
                child: Text(
                  TitlePageMessage.of(globalLanguageCode).howToPlay,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => launchUrlString(
                "https://sponge-spatula-07e.notion.site/FAQ-e49a7e9e8b2b4774af040220281c9115",
              ),
              icon: FaIcon(
                FontAwesomeIcons.question,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: FittedBox(
                child: Text(
                  TitlePageMessage.of(globalLanguageCode).faq,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => launchUrlString(
                TitlePageMessage.of(globalLanguageCode).feedbackUrl,
              ),
              icon: FaIcon(
                FontAwesomeIcons.comment,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: FittedBox(
                child: Text(
                  TitlePageMessage.of(globalLanguageCode).feedback,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => launchUrlString(
                "https://www.buymeacoffee.com/milosnaniwa",
              ),
              icon: FaIcon(
                FontAwesomeIcons.mugSaucer,
                size: MediaQuery.of(context).size.height * 0.02,
              ),
              label: FittedBox(
                child: Text(
                  TitlePageMessage.of(globalLanguageCode).supportCreator,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
            ),
          ),
          Visibility(
            visible: [
              EnvironmentConst.dev,
              EnvironmentConst.stage,
            ].contains(globalEnvironment),
            child: const Spacer(
              flex: 1,
            ),
          ),
          Visibility(
            visible: [
              EnvironmentConst.dev,
              EnvironmentConst.stage,
            ].contains(globalEnvironment),
            child: SizedBox(
              width: 240,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: const Text("開発者用"),
                    contentPadding: const EdgeInsets.all(24),
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PlayPage(
                              playerUnitList: [
                                UnitClassConst.blueRoyal,
                                UnitClassConst.sword,
                                UnitClassConst.pike,
                                UnitClassConst.crossbow,
                                UnitClassConst.lightCavalry,
                              ],
                              aiUnitList: [
                                UnitClassConst.redRoyal,
                                UnitClassConst.archer,
                                UnitClassConst.cavalry,
                                UnitClassConst.lancer,
                                UnitClassConst.scout,
                              ],
                              difficulty: HexagonConst.sergeant,
                              aiMode: true,
                            ),
                          ),
                        ),
                        child: const Text(
                          'AI対戦テスト',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () => throw Exception('test exception'),
                        child: const Text(
                          'Exception強制発生',
                        ),
                      ),
                    ],
                  ),
                ),
                icon: FaIcon(
                  FontAwesomeIcons.robot,
                  size: MediaQuery.of(context).size.height * 0.02,
                ),
                label: Text(
                  TitlePageMessage.of(globalLanguageCode).debugMode,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: globalLanguageCode == "ja"
                    ? null
                    : () {
                        globalLanguageCode = "ja";
                        globalKanjiMode = true;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const TitlePage(),
                          ),
                          (route) => false,
                        );
                      },
                child: Text(
                  "日本語",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
              ),
              Text(
                " / ",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                ),
              ),
              TextButton(
                onPressed: globalLanguageCode == "en"
                    ? null
                    : () {
                        globalLanguageCode = "en";
                        globalKanjiMode = false;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const TitlePage(),
                          ),
                          (route) => false,
                        );
                      },
                child: Text(
                  "English",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          FutureBuilder(
            future: () async {
              final packageInfo = await PackageInfo.fromPlatform();
              return packageInfo.version;
            }(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              return Text(
                "ver ${snapshot.data}",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                ),
              );
            },
          ),
          TextButton.icon(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ver 0.4.2",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_4_2,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.4.1",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_4_1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.4.0",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_4_0,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.3.3",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_3_3,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.3.2",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_3_2,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.3.1",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_3_1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.3.0",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_3_0,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.2.4",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_2_4,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.2.3",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_2_3,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.2.2",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_2_2,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.2.1",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_2_1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.2.0",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_2_0,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.1.2",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_1_2,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.1.1",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_1_1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.1.0",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_1_0,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.10",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_10,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.9",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_9,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.8",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_8,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.7",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_7,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.6",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_6,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.5",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_5,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.4",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_4,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.3",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_3,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.2",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_2,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "ver 0.0.1",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              TitlePageMessage.of(globalLanguageCode).version0_0_1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    label: Text(
                      TitlePageMessage.of(globalLanguageCode).close,
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.circleXmark,
                      size: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
            icon: FaIcon(
              FontAwesomeIcons.newspaper,
              size: MediaQuery.of(context).size.height * 0.02,
            ),
            label: Text(
              TitlePageMessage.of(globalLanguageCode).recentUpdate,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            "Created by Yuma Okuda",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          Text(
            "Inspired by War Chest",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          Text(
            "Rule designed by Trevor Benjamin & David Thompson",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.015,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          InkWell(
            onTap: () => launchUrlString(
              'https://github.com/MilosNaniwa/warchest-dojo',
            ),
            child: const FaIcon(
              FontAwesomeIcons.github,
              size: 24,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
