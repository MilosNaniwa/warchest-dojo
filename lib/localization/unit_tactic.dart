import 'package:warchest_dojo/const/unit_class_const.dart';

class UnitTactic {
  final Function(String?) unitClass;

  UnitTactic({
    required this.unitClass,
  });

  factory UnitTactic.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return UnitTactic.ja();
      case 'en':
        return UnitTactic.en();
      case 'zh':
        return UnitTactic.zh();
      case 'ko':
        return UnitTactic.ko();
      case 'ru':
        return UnitTactic.ru();
      case 'uk':
        return UnitTactic.uk();
      case 'hr':
        return UnitTactic.hr();
      case 'fr':
        return UnitTactic.fr();
      case 'it':
        return UnitTactic.it();
      default:
        return UnitTactic.en();
    }
  }

  factory UnitTactic.ja() {
    final map = {
      UnitClassConst.sword: "持久力：攻撃または占領後に通常移動を実行できる。",
      UnitClassConst.crossbow: "射撃：直線上で１マス離れた敵を攻撃できる。間に駒が存在する場合は攻撃が成立しない。",
      UnitClassConst.knight: "なし",
      UnitClassConst.archer: "狙撃：２マス離れた敵を攻撃できる。間に駒が存在しても攻撃は成立する。",
      UnitClassConst.cavalry: "速攻：通常移動後に攻撃できる。",
      UnitClassConst.lightCavalry: "なし",
      UnitClassConst.lancer: "突進：直線上で１マスおよび２マス離れた敵の手前まで移動し、攻撃できる。間に駒が存在する"
          "場合は攻撃が成立しない。",
      UnitClassConst.pike: "なし",
      UnitClassConst.mercenary: "即戦力：傭兵を雇用したとき、盤上にいる傭兵に軍事行動を実行させる。",
      UnitClassConst.ensign: "誘導：２マス以内にいる味方を１マス移動させる。",
      UnitClassConst.marshall: "指揮：２マス以内にいる味方に通常攻撃させる。",
      UnitClassConst.berserker: "凶暴：軍事行動を実行後、強化に用いた駒をひとつ捨て、追加で軍事行動を実行できる。",
      UnitClassConst.warriorPriest: "神託：攻撃または占領後に駒を１枚ドローし、即座に使用する。",
      UnitClassConst.footman: "統率：手札を起点に軍事行動する際、盤上の２駒は同時に行動できる。",
      UnitClassConst.scout: "なし",
      UnitClassConst.royalGuard: "なし",
      UnitClassConst.blueRoyal: "なし",
      UnitClassConst.redRoyal: "なし",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.en() {
    final map = {
      UnitClassConst.sword: "After the Swordman attacks or dominates, it may move.",
      UnitClassConst.crossbow: "Attack a unit two spaces away in a straight line. The intervening"
          " space cannot be occupied by a unit.",
      UnitClassConst.knight: "None",
      UnitClassConst.archer:
          "Attack a unit two spaces away. The intervening space may be occupied by a unit.",
      UnitClassConst.cavalry: "Move and then attack.",
      UnitClassConst.lightCavalry: "None",
      UnitClassConst.lancer: "Move one or two spaces and then attack, all in a straight line.",
      UnitClassConst.pike: "None",
      UnitClassConst.mercenary: "After you recruit a Mercenary, you may maneuver your Mercenary "
          "unit.",
      UnitClassConst.ensign: "Choose a friendly unit within two spaces of the Ensign. The chosen "
          "unit performs a normal move to a space within two spaces of the Ensign.",
      UnitClassConst.marshall:
          "Choose a friendly unit that is within two spaces of the Marshall. The chosen unit "
              "attacks,  if able.",
      UnitClassConst.berserker: "After the Berserker maneuvers, you may maneuver it again by "
          "discarding a bolstered coin from the Berserker unit. You may do this multiple times, "
          "but you may not remove the final coin.",
      UnitClassConst.warriorPriest: "After the Warrior Priest attacks or dominates, draw one coin"
          " from your bag and immediately use it to take any action.",
      UnitClassConst.footman: "Perform one maneuver with each Footman unit on the board.",
      UnitClassConst.scout: "None",
      UnitClassConst.royalGuard: "None",
      UnitClassConst.blueRoyal: "None",
      UnitClassConst.redRoyal: "None",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.zh() {
    final map = {
      UnitClassConst.sword: "剑士攻击或统治后，可能会移动。",
      UnitClassConst.crossbow: "直线攻击两格距离的单位。中间的空间不能被单位占据。",
      UnitClassConst.knight: "无",
      UnitClassConst.archer: "攻击两格距离的单位。中间的空间可能被单位占据。",
      UnitClassConst.cavalry: "移动然后攻击。",
      UnitClassConst.lightCavalry: "无",
      UnitClassConst.lancer: "直线移动一或两个空格然后攻击。",
      UnitClassConst.pike: "无",
      UnitClassConst.mercenary: "招募佣兵后，你可能会操控你的佣兵单位。",
      UnitClassConst.ensign: "选择旗手两格范围内的友方单位。选中的单位正常移动到旗手两格范围内的空格。",
      UnitClassConst.marshall: "选择元帅两格范围内的友方单位。选中的单位攻击，如果可能的话。",
      UnitClassConst.berserker: "狂战士操纵后，你可以通过从狂战士单位中丢弃一个加强的硬币再次操纵它。你可以多次这样做，但是你不能移除最后一个硬币。",
      UnitClassConst.warriorPriest: "战士祭司攻击或统治后，从你的袋子中抽取一个硬币并立即使用它执行任何动作。",
      UnitClassConst.footman: "用棋盘上的每个步兵单位执行一次操纵。",
      UnitClassConst.scout: "无",
      UnitClassConst.royalGuard: "无",
      UnitClassConst.blueRoyal: "无",
      UnitClassConst.redRoyal: "无",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.ko() {
    final map = {
      UnitClassConst.sword: "검사가 공격하거나 지배한 후 이동할 수 있습니다.",
      UnitClassConst.crossbow: "직선으로 두 칸 떨어진 곳에 있는 유닛을 공격합니다. 사이에 있는 공간에 유닛이 있어서는 안됩니다.",
      UnitClassConst.knight: "없음",
      UnitClassConst.archer: "두 칸 떨어진 곳에 있는 유닛을 공격합니다. 사이의 공간은 유닛으로 차지될 수 있습니다.",
      UnitClassConst.cavalry: "이동하고 공격합니다.",
      UnitClassConst.lightCavalry: "없음",
      UnitClassConst.lancer: "한 또는 두 칸을 이동하고 공격합니다. 이동과 공격은 모두 직선 방향으로 이루어져야 합니다.",
      UnitClassConst.pike: "없음",
      UnitClassConst.mercenary: "용병을 고용하면, 당신의 용병 유닛을 조작할 수 있습니다.",
      UnitClassConst.ensign:
          "기장이 두 칸 이내에 있는 우호적인 유닛을 선택합니다. 선택된 유닛은 기장이 있는 두 칸 이내의 공간으로 정상적으로 이동합니다.",
      UnitClassConst.marshall: "마샬이 두 칸 이내에 있는 우호적인 유닛을 선택합니다. 선택된 유닛은 공격합니다, 가능하다면.",
      UnitClassConst.berserker:
          "광전사가 움직인 후, 광전사 유닛에서 강화된 코인을 버려서 다시 움직일 수 있습니다. 이는 여러 번 가능하지만, 마지막 코인은 제거할 수 없습니다.",
      UnitClassConst.warriorPriest: "전사 사제가 공격하거나 지배한 후, 당신의 가방에서 코인 하나를 뽑아 어떤 행동이라도 즉시 취합니다.",
      UnitClassConst.footman: "보드 상의 각 보병 유닛으로 한 번의 움직임을 수행합니다.",
      UnitClassConst.scout: "없음",
      UnitClassConst.royalGuard: "없음",
      UnitClassConst.blueRoyal: "없음",
      UnitClassConst.redRoyal: "없음",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.ru() {
    final map = {
      UnitClassConst.sword: "После того как мечник атакует или доминирует, он может переместиться.",
      UnitClassConst.crossbow:
          "Атакуйте юнит на расстоянии двух клеток по прямой линии. Промежуточное пространство не может быть занято юнитом.",
      UnitClassConst.knight: "Нет",
      UnitClassConst.archer:
          "Атакуйте юнит на расстоянии двух клеток. Промежуточное пространство может быть занято юнитом.",
      UnitClassConst.cavalry: "Переместиться и затем атаковать.",
      UnitClassConst.lightCavalry: "Нет",
      UnitClassConst.lancer:
          "Перемещайтесь на одну или две клетки, а затем атакуйте, все по прямой линии.",
      UnitClassConst.pike: "Нет",
      UnitClassConst.mercenary:
          "После того как вы наняли наемника, вы можете маневрировать своим наемным юнитом.",
      UnitClassConst.ensign:
          "Выберите дружественную единицу в радиусе двух клеток от флажка. Выбранная единица выполняет нормальное перемещение на клетку в пределах двух клеток от флажка.",
      UnitClassConst.marshall:
          "Выберите дружественную единицу, которая находится в пределах двух клеток от маршала. Выбранная единица атакует, если это возможно.",
      UnitClassConst.berserker:
          "После того как берсерк маневрирует, вы можете снова переместить его, выбросив усиленную монету из единицы берсерка. Вы можете сделать это несколько раз, но вы не можете удалить последнюю монету.",
      UnitClassConst.warriorPriest:
          "После того как воин-жрец атакует или доминирует, вытащите одну монету из своего мешка и немедленно используйте ее для выполнения любого действия.",
      UnitClassConst.footman: "Выполните один маневр с каждым юнитом пехотинца на доске.",
      UnitClassConst.scout: "Нет",
      UnitClassConst.royalGuard: "Нет",
      UnitClassConst.blueRoyal: "Нет",
      UnitClassConst.redRoyal: "Нет",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.uk() {
    final map = {
      UnitClassConst.sword: "Після атаки або домінування Мечника, він може переміститися.",
      UnitClassConst.crossbow:
          "Атакуйте одиницю на відстані двох клітин по прямій. Проміжне простір не може бути зайнятий одиницею.",
      UnitClassConst.knight: "Немає",
      UnitClassConst.archer:
          "Атакуйте одиницю на відстані двох клітин. Проміжний простір може бути зайнятий одиницею.",
      UnitClassConst.cavalry: "Рухайтеся, а потім атакуйте.",
      UnitClassConst.lightCavalry: "Немає",
      UnitClassConst.lancer:
          "Рухайтесь на одну або дві клітини, а потім атакуйте, все по прямій лінії.",
      UnitClassConst.pike: "Немає",
      UnitClassConst.mercenary:
          "Після найму Наемника, ви можете маневрувати своєю найманою одиницею.",
      UnitClassConst.ensign:
          "Виберіть дружню одиницю на відстані двох клітин від Військового. Вибрана одиниця робить звичайний рух до клітини на відстані двох клітин від Військового.",
      UnitClassConst.marshall:
          "Виберіть дружню одиницю, що знаходиться на відстані двох клітин від Маршала. Вибрана одиниця атакує, якщо можливо.",
      UnitClassConst.berserker:
          "Після маневрування Берсерка, ви можете знову ним маневрувати, викинувши посилену монету з одиниці Берсерка. Ви можете це робити декілька разів, але ви не можете видалити останню монету.",
      UnitClassConst.warriorPriest:
          "Після атаки або домінування Воїна-Священника, вийміть одну монету зі свого мішка і негайно використайте її для виконання будь-якої дії.",
      UnitClassConst.footman: "Виконайте один маневр з кожною піхотною одиницею на дошці.",
      UnitClassConst.scout: "Немає",
      UnitClassConst.royalGuard: "Немає",
      UnitClassConst.blueRoyal: "Немає",
      UnitClassConst.redRoyal: "Немає",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.hr() {
    final map = {
      UnitClassConst.sword: "Nakon što Mačevalac napadne ili dominira, može se pomaknuti.",
      UnitClassConst.crossbow:
          "Napadnite jedinicu dva prostora dalje u ravnoj liniji. Prostor između ne može biti zauzet jedinicom.",
      UnitClassConst.knight: "Nema",
      UnitClassConst.archer:
          "Napadnite jedinicu dva prostora dalje. Prostor između može biti zauzet jedinicom.",
      UnitClassConst.cavalry: "Pomaknite se, a zatim napadnite.",
      UnitClassConst.lightCavalry: "Nema",
      UnitClassConst.lancer:
          "Pomaknite se jedan ili dva prostora, a zatim napadnite, sve u ravnoj liniji.",
      UnitClassConst.pike: "Nema",
      UnitClassConst.mercenary:
          "Nakon što unajmite Plaćenika, možete manevrirati svojom jedinicom Plaćenika.",
      UnitClassConst.ensign:
          "Izaberite prijateljsku jedinicu unutar dva prostora od Zastavnika. Odabrana jedinica izvodi normalni potez na prostor unutar dva prostora od Zastavnika.",
      UnitClassConst.marshall:
          "Izaberite prijateljsku jedinicu koja je unutar dva prostora od Maršala. Odabrana jedinica napada, ako je to moguće.",
      UnitClassConst.berserker:
          "Nakon što Berserker manevrira, možete ga ponovno manevrirati odbacivanjem pojačanog novčića iz jedinice Berserker. To možete učiniti više puta, ali ne možete ukloniti zadnji novčić.",
      UnitClassConst.warriorPriest:
          "Nakon što Ratni svećenik napadne ili dominira, izvucite jedan novčić iz svoje vreće i odmah ga upotrijebite za bilo koju akciju.",
      UnitClassConst.footman: "Izvedite jedan manevar sa svakom jedinicom Pješadinca na ploči.",
      UnitClassConst.scout: "Nema",
      UnitClassConst.royalGuard: "Nema",
      UnitClassConst.blueRoyal: "Nema",
      UnitClassConst.redRoyal: "Nema",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.fr() {
    final map = {
      UnitClassConst.sword: "Après que l'épéiste attaque ou domine, il peut se déplacer.",
      UnitClassConst.crossbow:
          "Attaquez une unité à deux espaces de distance en ligne droite. L'espace intermédiaire ne peut pas être occupé par une unité.",
      UnitClassConst.knight: "Aucun",
      UnitClassConst.archer:
          "Attaquez une unité à deux espaces de distance. L'espace intermédiaire peut être occupé par une unité.",
      UnitClassConst.cavalry: "Déplacez-vous puis attaquez.",
      UnitClassConst.lightCavalry: "Aucun",
      UnitClassConst.lancer:
          "Déplacez-vous d'un ou deux espaces puis attaquez, tout en ligne droite.",
      UnitClassConst.pike: "Aucun",
      UnitClassConst.mercenary:
          "Après avoir recruté un Mercenaire, vous pouvez manœuvrer votre unité de Mercenaire.",
      UnitClassConst.ensign:
          "Choisissez une unité amie à deux espaces de l'Enseigne. L'unité choisie effectue un déplacement normal vers un espace à deux espaces de l'Enseigne.",
      UnitClassConst.marshall:
          "Choisissez une unité amie qui se trouve à deux espaces du Maréchal. L'unité choisie attaque, si possible.",
      UnitClassConst.berserker:
          "Après que le Berserker a manœuvré, vous pouvez le manœuvrer à nouveau en écartant une pièce renforcée de l'unité Berserker. Vous pouvez le faire plusieurs fois, mais vous ne pouvez pas enlever la dernière pièce.",
      UnitClassConst.warriorPriest:
          "Après que le Prêtre Guerrier attaque ou domine, piochez une pièce de votre sac et utilisez-la immédiatement pour effectuer n'importe quelle action.",
      UnitClassConst.footman:
          "Effectuez une manœuvre avec chaque unité de Fantassin sur le plateau.",
      UnitClassConst.scout: "Aucun",
      UnitClassConst.royalGuard: "Aucun",
      UnitClassConst.blueRoyal: "Aucun",
      UnitClassConst.redRoyal: "Aucun",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitTactic.it() {
    final map = {
      UnitClassConst.sword: "Dopo che il Spadaccino attacca o domina, può muoversi.",
      UnitClassConst.crossbow:
          "Attacca un'unità a due spazi di distanza in linea retta. Lo spazio intermedio non può essere occupato da un'unità.",
      UnitClassConst.knight: "Nessuno",
      UnitClassConst.archer:
          "Attacca un'unità a due spazi di distanza. Lo spazio intermedio può essere occupato da un'unità.",
      UnitClassConst.cavalry: "Muoviti e poi attacca.",
      UnitClassConst.lightCavalry: "Nessuno",
      UnitClassConst.lancer: "Muoviti di uno o due spazi e poi attacca, tutto in linea retta.",
      UnitClassConst.pike: "Nessuno",
      UnitClassConst.mercenary:
          "Dopo aver reclutato un Mercenario, puoi manovrare la tua unità Mercenario.",
      UnitClassConst.ensign:
          "Scegli un'unità amica a due spazi dall'Insegna. L'unità scelta esegue una mossa normale verso uno spazio a due spazi dall'Insegna.",
      UnitClassConst.marshall:
          "Scegli un'unità amica che si trova a due spazi dal Maresciallo. L'unità scelta attacca, se possibile.",
      UnitClassConst.berserker:
          "Dopo che il Berserker ha manovrato, puoi manovrarlo di nuovo scartando una moneta potenziata dall'unità Berserker. Puoi farlo più volte, ma non puoi rimuovere l'ultima moneta.",
      UnitClassConst.warriorPriest:
          "Dopo che il Prete Guerriero attacca o domina, pesca una moneta dalla tua borsa e usala immediatamente per eseguire qualsiasi azione.",
      UnitClassConst.footman: "Esegui una manovra con ogni unità di Fante sulla scacchiera.",
      UnitClassConst.scout: "Nessuno",
      UnitClassConst.royalGuard: "Nessuno",
      UnitClassConst.blueRoyal: "Nessuno",
      UnitClassConst.redRoyal: "Nessuno",
    };

    return UnitTactic(
      unitClass: (unitId) => map[unitId],
    );
  }
}
