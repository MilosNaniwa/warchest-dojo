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
      case 'zh':
        return PlayPageMessage.zh();
      case 'ko':
        return PlayPageMessage.ko();
      case 'ru':
        return PlayPageMessage.ru();
      case 'uk':
        return PlayPageMessage.uk();
      case 'hr':
        return PlayPageMessage.hr();
      case 'fr':
        return PlayPageMessage.fr();
      case 'it':
        return PlayPageMessage.it();
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

  factory PlayPageMessage.zh() => PlayPageMessage(
        hand: "手牌",
        supply: '补给',
        discard: '弃牌',
        cemetery: '墓地',
        understood: '明白了',
        thankYou: '谢谢',
        computer: '红军',
        player: '蓝军',
        thereIsNoUnitToRecruit: '没有可招募的单位。',
        warChestDojo: '战争宝箱道场',
        turnOfPlayerOrComputer: "{team}的回合",
        wantToRematch: '你想重新比赛吗？',
        rematch: '重新比赛',
        supportCreator: '捐赠',
        selectYourAction: '选择你的行动',
        bolster: "加强",
        dominate: "主导",
        pass: "放弃",
        takeInitiative: "采取主动",
        playerOrComputerPassed: "{team}已经放弃。",
        playerOrComputerHasTakenInitiative: "{team}采取了主动。",
        playerOrComputerHasWon: "{team}已经赢了。",
        maneuver: "策略",
        whichFootmanWillMoveFirst: "选择首先移动的步兵。",
        maneuverMyFootman: "移动我的步兵。",
        deployNewFootman: "部署新的步兵。",
        unitWasBolstered: "{team}的{unit}得到了加强。",
        unitWasDeployed: "{team}的{unit}被部署到{location}。",
        unitWasMoved: "{team}的{unit}从{from}移动到{to}。",
        unitWasAttacked: "{team}的{unit}攻击了{target}。",
        unitWasCounterattackedByPikeman: "{team}的{unit}被长枪兵反击。",
        unitWasDominated: "{team}的{unit}主导了{location}。",
        unitWasRecruited: "{team}招募了{unit}。",
        gameStarted: "游戏开始。",
        pleaseSelectHandFirst: "请先从手中选择一个硬币进行操作。",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.ko() => PlayPageMessage(
        hand: "손패",
        supply: '공급',
        discard: '버림',
        cemetery: '묘지',
        understood: '이해했습니다',
        thankYou: '감사합니다',
        computer: '붉은 군대',
        player: '파란 군대',
        thereIsNoUnitToRecruit: '모집할 수 있는 유닛이 없습니다.',
        warChestDojo: '전쟁 보물 도장',
        turnOfPlayerOrComputer: "{team}의 턴",
        wantToRematch: '재대결 하시겠습니까?',
        rematch: '재대결',
        supportCreator: '기부',
        selectYourAction: '동작을 선택하세요',
        bolster: "강화",
        dominate: "지배",
        pass: "패스",
        takeInitiative: "주도권 가져오기",
        playerOrComputerPassed: "{team}이 패스했습니다.",
        playerOrComputerHasTakenInitiative: "{team}이 주도권을 가져왔습니다.",
        playerOrComputerHasWon: "{team}이 이겼습니다.",
        maneuver: "전략 이동",
        whichFootmanWillMoveFirst: "먼저 움직일 보병을 선택하세요.",
        maneuverMyFootman: "내 보병을 움직이세요.",
        deployNewFootman: "새로운 보병을 배치하세요.",
        unitWasBolstered: "{team}의 {unit}이 강화되었습니다.",
        unitWasDeployed: "{team}의 {unit}이 {location}에 배치되었습니다.",
        unitWasMoved: "{team}의 {unit}이 {from}에서 {to}로 이동했습니다.",
        unitWasAttacked: "{team}의 {unit}이 {target}을 공격했습니다.",
        unitWasCounterattackedByPikeman: "{team}의 {unit}이 창병에게 반격을 받았습니다.",
        unitWasDominated: "{team}의 {unit}이 {location}을 지배했습니다.",
        unitWasRecruited: "{team}이 {unit}을 모집했습니다.",
        gameStarted: "게임이 시작되었습니다.",
        pleaseSelectHandFirst: "행동을 취하기 위해 먼저 손에서 코인을 선택하세요.",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.ru() => PlayPageMessage(
        hand: "В руке",
        supply: 'Поставка',
        discard: 'Сброс',
        cemetery: 'Кладбище',
        understood: 'Понял',
        thankYou: 'Спасибо',
        computer: 'Красная армия',
        player: 'Синяя армия',
        thereIsNoUnitToRecruit: 'Нет доступных для найма юнитов.',
        warChestDojo: 'Додзё военного сундука',
        turnOfPlayerOrComputer: "Ход {team}",
        wantToRematch: 'Хотите реванш?',
        rematch: 'Реванш',
        supportCreator: 'Пожертвовать',
        selectYourAction: 'Выберите ваше действие',
        bolster: "Укрепить",
        dominate: "Доминировать",
        pass: "Пропустить",
        takeInitiative: "Взять инициативу",
        playerOrComputerPassed: "{team} пропустил.",
        playerOrComputerHasTakenInitiative: "{team} взял инициативу.",
        playerOrComputerHasWon: "{team} победил.",
        maneuver: "Манёвр",
        whichFootmanWillMoveFirst: "Выберите, кого передвинуть вперёд.",
        maneuverMyFootman: "Переместить моего пехотинца.",
        deployNewFootman: "Развернуть нового пехотинца.",
        unitWasBolstered: "{unit} от {team} был укреплён.",
        unitWasDeployed: "{unit} от {team} был развернут в {location}.",
        unitWasMoved: "{unit} от {team} был перемещён из {from} в {to}.",
        unitWasAttacked: "{unit} от {team} атаковал {target}.",
        unitWasCounterattackedByPikeman: "{unit} от {team} был контратакован пикейщиком.",
        unitWasDominated: "{unit} от {team} доминировал в {location}.",
        unitWasRecruited: "{team} нанял {unit}.",
        gameStarted: "Игра началась.",
        pleaseSelectHandFirst: "Пожалуйста, выберите монету из руки, чтобы выполнить действие.",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.uk() => PlayPageMessage(
        hand: "У руці",
        supply: 'Постачання',
        discard: 'Відкинути',
        cemetery: 'Цвинтар',
        understood: 'Зрозуміло',
        thankYou: 'Дякую',
        computer: 'Червона армія',
        player: 'Блакитна армія',
        thereIsNoUnitToRecruit: 'Немає доступних юнітів для найму.',
        warChestDojo: 'Додзьо військової скарбнички',
        turnOfPlayerOrComputer: "Хід {team}",
        wantToRematch: 'Хочете реванш?',
        rematch: 'Реванш',
        supportCreator: 'Пожертвувати',
        selectYourAction: 'Оберіть свою дію',
        bolster: "Посилити",
        dominate: "Домінувати",
        pass: "Пропустити",
        takeInitiative: "Взяти ініціативу",
        playerOrComputerPassed: "{team} пропустив.",
        playerOrComputerHasTakenInitiative: "{team} взяв ініціативу.",
        playerOrComputerHasWon: "{team} переміг.",
        maneuver: "Маневр",
        whichFootmanWillMoveFirst: "Оберіть, кого пересунути спочатку.",
        maneuverMyFootman: "Перемістіть мого піхотинця.",
        deployNewFootman: "Розгорніть нового піхотинця.",
        unitWasBolstered: "{unit} від {team} було посилена.",
        unitWasDeployed: "{unit} від {team} було розгорнено у {location}.",
        unitWasMoved: "{unit} від {team} перемістився з {from} до {to}.",
        unitWasAttacked: "{unit} від {team} атакував {target}.",
        unitWasCounterattackedByPikeman: "{unit} від {team} було контратаковано пікенером.",
        unitWasDominated: "{unit} від {team} домінував у {location}.",
        unitWasRecruited: "{team} найняв {unit}.",
        gameStarted: "Гра почалась.",
        pleaseSelectHandFirst: "Будь ласка, спочатку оберіть монету з руки, щоб виконати дію.",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.hr() => PlayPageMessage(
        hand: "Ruka",
        supply: 'Nabava',
        discard: 'Odbaci',
        cemetery: 'Groblje',
        understood: 'Razumijem',
        thankYou: 'Hvala',
        computer: 'Crvena armija',
        player: 'Plava armija',
        thereIsNoUnitToRecruit: 'Nema dostupnih jedinica za regrutaciju.',
        warChestDojo: 'Ratna prsa Dojo',
        turnOfPlayerOrComputer: "Potez {team}",
        wantToRematch: 'Želite li ponovno igrati?',
        rematch: 'Ponovna igra',
        supportCreator: 'Doniraj',
        selectYourAction: 'Odaberite svoju radnju',
        bolster: "Ojačaj",
        dominate: "Dominiraj",
        pass: "Prepusti",
        takeInitiative: "Preuzmi inicijativu",
        playerOrComputerPassed: "{team} je prepustio.",
        playerOrComputerHasTakenInitiative: "{team} je preuzeo inicijativu.",
        playerOrComputerHasWon: "{team} je pobijedio.",
        maneuver: "Manevriranje",
        whichFootmanWillMoveFirst: "Odaberite kojeg pješaka premjestiti prvo.",
        maneuverMyFootman: "Premjesti mojeg pješaka.",
        deployNewFootman: "Rasporedi novog pješaka.",
        unitWasBolstered: "{unit} od {team} je ojačan.",
        unitWasDeployed: "{unit} od {team} je raspoređen na {location}.",
        unitWasMoved: "{unit} od {team} je premješten iz {from} u {to}.",
        unitWasAttacked: "{unit} od {team} napao je {target}.",
        unitWasCounterattackedByPikeman: "{unit} od {team} je kontranapadnut od strane pikeman-a.",
        unitWasDominated: "{unit} od {team} dominirao je na {location}.",
        unitWasRecruited: "{team} je regrutirao {unit}.",
        gameStarted: "Igra je počela.",
        pleaseSelectHandFirst: "Molimo prvo odaberite kovanicu iz ruke za izvođenje radnje.",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.fr() => PlayPageMessage(
        hand: "Main",
        supply: 'Ravitaillement',
        discard: 'Défausse',
        cemetery: 'Cimetière',
        understood: 'Compris',
        thankYou: 'Merci',
        computer: 'Armée rouge',
        player: 'Armée bleue',
        thereIsNoUnitToRecruit: 'Il n’y a pas d’unité à recruter.',
        warChestDojo: 'Dojo du coffre de guerre',
        turnOfPlayerOrComputer: "Tour de {team}",
        wantToRematch: 'Voulez-vous une revanche ?',
        rematch: 'Revanche',
        supportCreator: 'Faire un don',
        selectYourAction: 'Sélectionnez votre action',
        bolster: "Renforcer",
        dominate: "Dominer",
        pass: "Passer",
        takeInitiative: "Prendre l'initiative",
        playerOrComputerPassed: "{team} a passé son tour.",
        playerOrComputerHasTakenInitiative: "{team} a pris l'initiative.",
        playerOrComputerHasWon: "{team} a gagné.",
        maneuver: "Manœuvre",
        whichFootmanWillMoveFirst: "Sélectionnez le fantassin à déplacer en premier.",
        maneuverMyFootman: "Déplacez mon fantassin existant.",
        deployNewFootman: "Déployez un nouveau fantassin.",
        unitWasBolstered: "{unit} de {team} a été renforcé.",
        unitWasDeployed: "{unit} de {team} a été déployé à {location}.",
        unitWasMoved: "{unit} de {team} a été déplacé de {from} à {to}.",
        unitWasAttacked: "{unit} de {team} a attaqué {target}.",
        unitWasCounterattackedByPikeman: "{unit} de {team} a été contre-attaqué par un piquier.",
        unitWasDominated: "{unit} de {team} a dominé {location}.",
        unitWasRecruited: "{team} a recruté {unit}.",
        gameStarted: "La partie a commencé.",
        pleaseSelectHandFirst:
            "Veuillez d'abord sélectionner une pièce de votre main pour prendre une action.",
        text19: "",
        text20: "",
      );

  factory PlayPageMessage.it() => PlayPageMessage(
        hand: "Mano",
        supply: 'Rifornimento',
        discard: 'Scarta',
        cemetery: 'Cimitero',
        understood: 'Capito',
        thankYou: 'Grazie',
        computer: 'Esercito rosso',
        player: 'Esercito blu',
        thereIsNoUnitToRecruit: 'Non ci sono unità disponibili per il reclutamento.',
        warChestDojo: 'Dojo del Tesoro di Guerra',
        turnOfPlayerOrComputer: "Turno di {team}",
        wantToRematch: 'Vuoi la rivincita?',
        rematch: 'Rivincita',
        supportCreator: 'Dona',
        selectYourAction: 'Seleziona la tua azione',
        bolster: "Rafforza",
        dominate: "Domina",
        pass: "Passa",
        takeInitiative: "Prendi l'iniziativa",
        playerOrComputerPassed: "{team} ha passato il turno.",
        playerOrComputerHasTakenInitiative: "{team} ha preso l'iniziativa.",
        playerOrComputerHasWon: "{team} ha vinto.",
        maneuver: "Manovra",
        whichFootmanWillMoveFirst: "Seleziona quale pedone muovere per primo.",
        maneuverMyFootman: "Muovi il mio pedone esistente.",
        deployNewFootman: "Schiera un nuovo pedone.",
        unitWasBolstered: "{unit} di {team} è stato rafforzato.",
        unitWasDeployed: "{unit} di {team} è stato schierato a {location}.",
        unitWasMoved: "{unit} di {team} è stato spostato da {from} a {to}.",
        unitWasAttacked: "{unit} di {team} ha attaccato {target}.",
        unitWasCounterattackedByPikeman: "{unit} di {team} è stato contrattaccato da un picchiero.",
        unitWasDominated: "{unit} di {team} ha dominato {location}.",
        unitWasRecruited: "{team} ha reclutato {unit}.",
        gameStarted: "La partita è iniziata.",
        pleaseSelectHandFirst:
            "Per favore, seleziona prima una moneta dalla tua mano per eseguire un'azione.",
        text19: "",
        text20: "",
      );
}
