class PlayPageMessage {
  final String hand;
  final String supply;
  final String discard;
  final String cemetery;
  final String understood;
  final String thankYou;
  final String computer;
  final String player;
  final String thereIsNoUnitToRecruit;
  final String warChestDojo;
  final String turnOfPlayerOrComputer;
  final String wantToRematch;
  final String rematch;
  final String supportCreator;
  final String selectYourAction;
  final String bolster;
  final String dominate;
  final String pass;
  final String takeInitiative;
  final String playerOrComputerPassed;
  final String playerOrComputerHasTakenInitiative;
  final String playerOrComputerHasWon;
  final String maneuver;
  final String whichFootmanWillMoveFirst;
  final String maneuverMyFootman;
  final String deployNewFootman;
  final String unitWasBolstered;
  final String unitWasDeployed;
  final String unitWasMoved;
  final String unitWasAttacked;
  final String unitWasCounterattackedByPikeman;
  final String unitWasDominated;
  final String unitWasRecruited;
  final String gameStarted;
  final String pleaseSelectHandFirst;
  final String text19;
  final String text20;

  PlayPageMessage({
    required this.hand,
    required this.supply,
    required this.discard,
    required this.cemetery,
    required this.understood,
    required this.thankYou,
    required this.computer,
    required this.player,
    required this.thereIsNoUnitToRecruit,
    required this.warChestDojo,
    required this.turnOfPlayerOrComputer,
    required this.wantToRematch,
    required this.rematch,
    required this.supportCreator,
    required this.selectYourAction,
    required this.bolster,
    required this.dominate,
    required this.pass,
    required this.takeInitiative,
    required this.playerOrComputerPassed,
    required this.playerOrComputerHasTakenInitiative,
    required this.playerOrComputerHasWon,
    required this.maneuver,
    required this.whichFootmanWillMoveFirst,
    required this.maneuverMyFootman,
    required this.deployNewFootman,
    required this.unitWasBolstered,
    required this.unitWasDeployed,
    required this.unitWasMoved,
    required this.unitWasAttacked,
    required this.unitWasCounterattackedByPikeman,
    required this.unitWasDominated,
    required this.unitWasRecruited,
    required this.gameStarted,
    required this.pleaseSelectHandFirst,
    required this.text19,
    required this.text20,
  });

  factory PlayPageMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return PlayPageMessage.ja();
      case 'en':
        return PlayPageMessage.en();
      default:
        return PlayPageMessage.en();
    }
  }

  factory PlayPageMessage.ja() => PlayPageMessage(
        hand: "手札",
        supply: '雇用場',
        discard: '捨場',
        cemetery: '墓場',
        understood: '理解',
        thankYou: '感謝',
        computer: '赤軍',
        player: '青軍',
        thereIsNoUnitToRecruit: '雇用できる戦力がありません。',
        warChestDojo: '戦箱道場',
        turnOfPlayerOrComputer: '{team}の手番',
        wantToRematch: '再戦しますか？',
        rematch: '再戦',
        supportCreator: '製作者を支援する',
        selectYourAction: '行動を選択',
        bolster: "強化",
        dominate: "占領",
        pass: "パス",
        takeInitiative: "先攻奪取",
        playerOrComputerPassed: "{team}がパスしました。",
        playerOrComputerHasTakenInitiative: "{team}が先攻を奪取しました。",
        playerOrComputerHasWon: "{team}の勝利",
        maneuver: "操作",
        whichFootmanWillMoveFirst: "最初に操作する従兵を選択",
        maneuverMyFootman: "既存の従兵を操作",
        deployNewFootman: "新たに従兵を展開",
        unitWasBolstered: "{team}の{unit}が強化されました。",
        unitWasDeployed: "{team}の{unit}が {location} に展開されました。",
        unitWasMoved: "{team}の{unit}が {from} から {to} へ移動しました。",
        unitWasAttacked: "{team}の{unit}が{target}を攻撃しました。",
        unitWasCounterattackedByPikeman: "槍兵の戦術により{unit}が反撃を受けました。",
        unitWasDominated: "{team}の{unit}が {location} を占領しました。",
        unitWasRecruited: "{team}が{unit}を雇用しました。",
        gameStarted: "ゲーム開始",
        pleaseSelectHandFirst: "行動する場合は手札を選択してください。",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.en() => PlayPageMessage(
        hand: "Hand",
        supply: 'Supply',
        discard: 'Discard',
        cemetery: 'Cemetery',
        understood: 'Understood',
        thankYou: 'Thank you',
        computer: 'Red army',
        player: 'Blue army',
        thereIsNoUnitToRecruit: 'There are no units available to recruit.',
        warChestDojo: 'War Chest Dojo',
        turnOfPlayerOrComputer: "{team}'s turn",
        wantToRematch: 'Do you want to rematch?',
        rematch: 'Rematch',
        supportCreator: 'Donate',
        selectYourAction: 'Select your action',
        bolster: "Bolster",
        dominate: "Dominate",
        pass: "Pass",
        takeInitiative: "Take Initiative",
        playerOrComputerPassed: "{team} has passed.",
        playerOrComputerHasTakenInitiative: "{team} has taken the initiative.",
        playerOrComputerHasWon: "{team} has won.",
        maneuver: "Maneuver",
        whichFootmanWillMoveFirst: "Select the footman to move first.",
        maneuverMyFootman: "Move my existing footman.",
        deployNewFootman: "Deploy a new footman.",
        unitWasBolstered: "{unit} of {team} was bolstered.",
        unitWasDeployed: "{unit} of {team} was deployed to {location}.",
        unitWasMoved: "{unit} of {team} was moved from {from} to {to}.",
        unitWasAttacked: "{unit} of {team} attacked {target}.",
        unitWasCounterattackedByPikeman: "{unit} of {team} was counterattacked by a pikeman.",
        unitWasDominated: "{unit} of {team} dominated {location}.",
        unitWasRecruited: "{team} recruited {unit}.",
        gameStarted: "Game started.",
        pleaseSelectHandFirst: "Please select a coin from your hand to take an action.",
        text19: "",
        text20: "",
      );
}
