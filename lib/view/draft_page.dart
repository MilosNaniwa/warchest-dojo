import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/localization/draft_page_message.dart';
import 'package:warchest_dojo/util/util.dart';
import 'package:warchest_dojo/view/play_page/play_page.dart';
import 'package:warchest_dojo/widget/unit_coin.dart';

class DraftPage extends StatefulWidget {
  final bool randomMode;
  final String difficulty;

  const DraftPage({
    Key? key,
    required this.randomMode,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<DraftPage> createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {
  late List<String> _unitClassList;
  late List<String> _aiSelectableUnit;

  late List<String> _playerUnitClassList;
  late List<String> _cpuUnitClassList;

  late bool _isPlayerPhase;

  @override
  void initState() {
    super.initState();
    _unitClassList = [];
    _aiSelectableUnit = [];

    _isPlayerPhase = true;

    _unitClassList.addAll(
      [
        UnitClassConst.sword,
        UnitClassConst.scout,
        UnitClassConst.pike,
        UnitClassConst.crossbow,
        UnitClassConst.knight,
        UnitClassConst.cavalry,
        UnitClassConst.lightCavalry,
        UnitClassConst.warriorPriest,
        UnitClassConst.lancer,
        UnitClassConst.archer,
        UnitClassConst.mercenary,
        UnitClassConst.royalGuard,
        UnitClassConst.marshall,
        UnitClassConst.ensign,
        UnitClassConst.footman,
        UnitClassConst.berserker,
      ],
    );

    _aiSelectableUnit.addAll(
      [
        UnitClassConst.sword,
        UnitClassConst.scout,
        UnitClassConst.pike,
        UnitClassConst.crossbow,
        UnitClassConst.knight,
        UnitClassConst.cavalry,
        UnitClassConst.lightCavalry,
        UnitClassConst.warriorPriest,
        UnitClassConst.lancer,
        UnitClassConst.archer,
        UnitClassConst.mercenary,
        UnitClassConst.royalGuard,
        UnitClassConst.marshall,
        UnitClassConst.ensign,
        UnitClassConst.footman,
        UnitClassConst.berserker,
      ],
    );

    if (widget.randomMode == true) {
      _shuffleUnit();
    } else {
      _playerUnitClassList = [];
      _cpuUnitClassList = [];
    }
  }

  void _shuffleUnit() {
    _playerUnitClassList = [];
    _cpuUnitClassList = [];

    final tmpAllUnitList = List.of(_unitClassList);

    tmpAllUnitList.shuffle();

    _playerUnitClassList.addAll(
      tmpAllUnitList.sublist(0, 4),
    );

    final tmpCpuUsableUnitList = List.of(_aiSelectableUnit);
    tmpCpuUsableUnitList.removeWhere(
      (element) => _playerUnitClassList.contains(
        element,
      ),
    );

    tmpCpuUsableUnitList.shuffle();

    _cpuUnitClassList.addAll(
      tmpCpuUsableUnitList.sublist(0, 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DraftPageMessage.of(globalLanguageCode).draft,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            color: Colors.blueAccent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: _isPlayerPhase == true &&
                              (_playerUnitClassList + _cpuUnitClassList).length < 8,
                          child: Text(
                            DraftPageMessage.of(globalLanguageCode).selecting,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          DraftPageMessage.of(globalLanguageCode).player.replaceAll(
                                "{count}",
                                _playerUnitClassList.length.toString(),
                              ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: List.generate(
                        _playerUnitClassList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      _playerUnitClassList.removeAt(index);
                                      _isPlayerPhase = true;
                                    }),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: UnitCoinContainer(
                                            unitClass: _playerUnitClassList[index],
                                            size: 32,
                                            shouldHide: false,
                                            isSelected: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const FaIcon(
                                    FontAwesomeIcons.circleXmark,
                                    color: Colors.white70,
                                    size: 12,
                                  ),
                                ],
                              ),
                              Text(
                                Util.convertUnitClassToUnitName(
                                  unitClass: _playerUnitClassList[index],
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            color: Colors.pinkAccent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: _isPlayerPhase == false &&
                              (_playerUnitClassList + _cpuUnitClassList).length < 8,
                          child: Text(
                            DraftPageMessage.of(globalLanguageCode).selecting,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          DraftPageMessage.of(globalLanguageCode).computer.replaceAll(
                                "{count}",
                                _cpuUnitClassList.length.toString(),
                              ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: List.generate(
                        _cpuUnitClassList.length,
                        (index) => GestureDetector(
                          onTap: () => setState(() {
                            _cpuUnitClassList.removeAt(index);
                            if (_playerUnitClassList.length < 4) {
                              _isPlayerPhase = true;
                            } else {
                              _isPlayerPhase = false;
                            }
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: UnitCoinContainer(
                                        unitClass: _cpuUnitClassList[index],
                                        size: 32,
                                        shouldHide: false,
                                        isSelected: false,
                                      ),
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.circleXmark,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                Text(
                                  Util.convertUnitClassToUnitName(
                                    unitClass: _cpuUnitClassList[index],
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                      _unitClassList.length,
                      (index) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: Card(
                            elevation: 4,
                            child: ListTile(
                              tileColor: _playerUnitClassList.contains(_unitClassList[index])
                                  ? Colors.blueAccent
                                  : _cpuUnitClassList.contains(_unitClassList[index])
                                      ? Colors.pinkAccent
                                      : Colors.transparent,
                              contentPadding: const EdgeInsets.all(16),
                              leading: UnitCoinContainer(
                                unitClass: _unitClassList[index],
                                size: 48,
                                shouldHide: false,
                                isSelected: false,
                              ),
                              title: Text(
                                Util.convertUnitClassToUnitName(
                                  unitClass: _unitClassList[index],
                                ),
                                style: TextStyle(
                                  color: (_playerUnitClassList + _cpuUnitClassList)
                                          .contains(_unitClassList[index])
                                      ? Colors.white
                                      : Theme.of(context).textTheme.bodyLarge!.color,
                                ),
                              ),
                              subtitle: Text(
                                Util.convertUnitClassToUnitDescription(
                                  unitClass: _unitClassList[index],
                                ),
                                style: TextStyle(
                                  color: (_playerUnitClassList + _cpuUnitClassList)
                                          .contains(_unitClassList[index])
                                      ? Colors.white70
                                      : Theme.of(context).textTheme.bodySmall!.color,
                                ),
                              ),
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Row(
                                    children: [
                                      UnitCoinContainer(
                                        unitClass: _unitClassList[index],
                                        size: 48,
                                        shouldHide: false,
                                        isSelected: false,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        Util.convertUnitClassToUnitName(
                                          unitClass: _unitClassList[index],
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.height * 0.1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DraftPageMessage.of(globalLanguageCode).tactic,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                Util.convertUnitClassToUnitTactic(
                                                  unitClass: _unitClassList[index],
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            DraftPageMessage.of(globalLanguageCode).characteristic,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                Util.convertUnitClassToUnitCharacteristic(
                                                  unitClass: _unitClassList[index],
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: _aiSelectableUnit.contains(
                                                  _unitClassList[index],
                                                ) ==
                                                false,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Wrap(
                                                  children: [
                                                    Text(
                                                      DraftPageMessage.of(globalLanguageCode)
                                                          .cpuCannotSelect,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton.icon(
                                      onPressed: () => Navigator.of(context).pop(),
                                      label: Text(
                                        DraftPageMessage.of(globalLanguageCode).close,
                                      ),
                                      icon: FaIcon(
                                        FontAwesomeIcons.circleXmark,
                                        size: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: (_playerUnitClassList + _cpuUnitClassList)
                                                      .contains(_unitClassList[index]) ==
                                                  true ||
                                              (_playerUnitClassList + _cpuUnitClassList).length >
                                                  7 ||
                                              (_isPlayerPhase == false &&
                                                  _aiSelectableUnit.contains(
                                                        _unitClassList[index],
                                                      ) ==
                                                      false)
                                          ? null
                                          : () {
                                              setState(() {
                                                if (_isPlayerPhase == true) {
                                                  if (_playerUnitClassList.length > 2) {
                                                    _isPlayerPhase = false;
                                                  }

                                                  _playerUnitClassList.add(
                                                    _unitClassList[index],
                                                  );
                                                } else {
                                                  _cpuUnitClassList.add(
                                                    _unitClassList[index],
                                                  );
                                                }
                                              });

                                              Navigator.of(context).pop();
                                            },
                                      label: Text(
                                        DraftPageMessage.of(globalLanguageCode).select,
                                      ),
                                      icon: FaIcon(
                                        FontAwesomeIcons.arrowPointer,
                                        size: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: "shuffle",
              backgroundColor: Colors.amber,
              child: const FaIcon(
                FontAwesomeIcons.recycle,
              ),
              onPressed: () async {
                final value = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                      DraftPageMessage.of(globalLanguageCode).doYouWantShuffle,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          DraftPageMessage.of(globalLanguageCode).no,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          DraftPageMessage.of(globalLanguageCode).yes,
                        ),
                      ),
                    ],
                  ),
                );

                if (value == true) {
                  setState(() {
                    _shuffleUnit();
                  });
                }
              }),
          const SizedBox(
            height: 16,
          ),
          Visibility(
            visible: (_playerUnitClassList + _cpuUnitClassList).length > 7,
            child: FloatingActionButton(
              heroTag: "accept",
              backgroundColor: Colors.green,
              child: const FaIcon(
                FontAwesomeIcons.check,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PlayPage(
                      difficulty: widget.difficulty,
                      playerUnitList: _playerUnitClassList
                        ..insert(
                          0,
                          UnitClassConst.blueRoyal,
                        ),
                      aiUnitList: _cpuUnitClassList
                        ..insert(
                          0,
                          UnitClassConst.redRoyal,
                        ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
