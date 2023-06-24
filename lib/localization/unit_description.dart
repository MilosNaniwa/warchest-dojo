import 'package:warchest_dojo/const/unit_class_const.dart';

class UnitDescription {
  final Function(String?) unitClass;

  UnitDescription({
    required this.unitClass,
  });

  factory UnitDescription.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return UnitDescription.ja();
      case 'en':
        return UnitDescription.en();
      case 'zh':
        return UnitDescription.zh();
      case 'ko':
        return UnitDescription.ko();
      case 'ru':
        return UnitDescription.ru();
      case 'uk':
        return UnitDescription.uk();
      case 'hr':
        return UnitDescription.hr();
      case 'fr':
        return UnitDescription.fr();
      case 'it':
        return UnitDescription.it();
      default:
        return UnitDescription.en();
    }
  }

  factory UnitDescription.ja() {
    final map = {
      UnitClassConst.sword: "攻撃または占領後に通常移動を実行できる。",
      UnitClassConst.crossbow: "直線上で２マス離れた敵を攻撃できる。",
      UnitClassConst.knight: "強化されていない敵から攻撃を受け付けない。",
      UnitClassConst.archer: "２マス離れた敵を攻撃できる。隣接した敵は攻撃はできない。",
      UnitClassConst.cavalry: "通常移動後に攻撃できる。",
      UnitClassConst.lightCavalry: "２マス移動できる。",
      UnitClassConst.lancer: "直線上で２マスおよび３マス離れた敵を攻撃できる。隣接した敵は攻撃できない。",
      UnitClassConst.pike: "攻撃を受けた際に攻撃者に反撃する。",
      UnitClassConst.mercenary: "傭兵を雇用したとき、盤上にいる傭兵に軍事行動を実行させる。",
      UnitClassConst.ensign: "２マス以内にいる味方を１マス移動させる。",
      UnitClassConst.marshall: "２マス以内にいる味方に通常攻撃させる。",
      UnitClassConst.berserker: "軍事行動を実行後、強化に用いた駒をひとつ捨て、追加で軍事行動を実行できる。",
      UnitClassConst.warriorPriest: "攻撃または占領後にコインを１枚ドローし、即座に使用する。",
      UnitClassConst.footman: "盤上に２体まで展開できる。展開された２体は同時に行動できる。",
      UnitClassConst.scout: "自陣営の拠点に限らず味方の隣マスに展開できる。",
      UnitClassConst.royalGuard: "攻撃を受けた際に駒を盤上ではなく雇用場から墓場に送れる。",
      UnitClassConst.blueRoyal: "勅令",
      UnitClassConst.redRoyal: "勅令",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.en() {
    final map = {
      UnitClassConst.sword: "Can perform normal movement after attacking or occupying.",
      UnitClassConst.crossbow: "Can attack enemies that are two squares away in a straight line.",
      UnitClassConst.knight: "Does not take damage from unenhanced enemy attacks.",
      UnitClassConst.archer:
          "Can attack enemies that are two squares away. Cannot attack adjacent enemies.",
      UnitClassConst.cavalry: "Can attack after performing normal movement.",
      UnitClassConst.lightCavalry: "Can move two squares.",
      UnitClassConst.lancer:
          "Can attack enemies that are two or three squares away in a straight line. Cannot attack adjacent enemies.",
      UnitClassConst.pike: "Counters the attacker when taking damage.",
      UnitClassConst.mercenary:
          "When hiring a mercenary, can perform a military action with a mercenary on the board.",
      UnitClassConst.ensign: "Can move an adjacent friendly piece up to one square.",
      UnitClassConst.marshall:
          "Can perform a normal attack with a friendly piece within two squares.",
      UnitClassConst.berserker:
          "After taking a military action, can discard a piece used for enhancement and perform an additional military action.",
      UnitClassConst.warriorPriest:
          "Can draw one coin and use it immediately after attacking or occupying.",
      UnitClassConst.footman:
          "Can deploy up to two pieces on the board. The two deployed pieces can move and take actions simultaneously.",
      UnitClassConst.scout:
          "Can be deployed adjacent to friendly pieces, not limited to the player's home base.",
      UnitClassConst.royalGuard:
          "When taking damage, can send the piece to the graveyard from the employment area instead of the board.",
      UnitClassConst.blueRoyal: "Edict",
      UnitClassConst.redRoyal: "Edict",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.ko() {
    final map = {
      UnitClassConst.sword: "공격이나 점령 후에도 일반 이동을 할 수 있습니다.",
      UnitClassConst.crossbow: "직선으로 두 칸 떨어진 적을 공격할 수 있습니다.",
      UnitClassConst.knight: "강화되지 않은 적의 공격으로부터 피해를 받지 않습니다.",
      UnitClassConst.archer: "두 칸 떨어진 적을 공격할 수 있습니다. 인접한 적은 공격할 수 없습니다.",
      UnitClassConst.cavalry: "일반 이동 후에 공격할 수 있습니다.",
      UnitClassConst.lightCavalry: "두 칸을 이동할 수 있습니다.",
      UnitClassConst.lancer: "직선으로 두 칸 또는 세 칸 떨어진 적을 공격할 수 있습니다. 인접한 적은 공격할 수 없습니다.",
      UnitClassConst.pike: "피해를 받을 때 공격자에게 반격합니다.",
      UnitClassConst.mercenary: "용병을 고용할 때, 보드 상의 용병으로 군사 행동을 수행할 수 있습니다.",
      UnitClassConst.ensign: "인접한 아군 말을 한 칸 이동시킬 수 있습니다.",
      UnitClassConst.marshall: "두 칸 이내의 아군 말로 일반 공격을 수행할 수 있습니다.",
      UnitClassConst.berserker: "군사 행동 후, 강화에 사용된 말을 버리고 추가적인 군사 행동을 수행할 수 있습니다.",
      UnitClassConst.warriorPriest: "공격이나 점령 후에 코인을 한 개 뽑고 즉시 사용할 수 있습니다.",
      UnitClassConst.footman: "보드에 최대 두 말을 배치할 수 있습니다. 두 배치된 말은 동시에 이동하고 행동을 수행할 수 있습니다.",
      UnitClassConst.scout: "아군 말에 인접한 곳에 배치할 수 있으며, 플레이어의 본진에 국한되지 않습니다.",
      UnitClassConst.royalGuard: "피해를 입을 때, 보드가 아닌 고용 영역에서 말을 무덤으로 보낼 수 있습니다.",
      UnitClassConst.blueRoyal: "칙령",
      UnitClassConst.redRoyal: "칙령",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.zh() {
    final map = {
      UnitClassConst.sword: "攻击或占领后可以进行正常移动。",
      UnitClassConst.crossbow: "可以攻击直线上距离两格远的敌人。",
      UnitClassConst.knight: "不会受到未强化敌人攻击的伤害。",
      UnitClassConst.archer: "可以攻击距离两格远的敌人。不能攻击相邻的敌人。",
      UnitClassConst.cavalry: "在执行正常移动后可以攻击。",
      UnitClassConst.lightCavalry: "可以移动两格。",
      UnitClassConst.lancer: "可以攻击直线上距离两或三格远的敌人。不能攻击相邻的敌人。",
      UnitClassConst.pike: "受到伤害时可以反击攻击者。",
      UnitClassConst.mercenary: "雇佣雇佣兵时，可以使用棋盘上的雇佣兵进行军事行动。",
      UnitClassConst.ensign: "可以移动相邻的友军棋子最多一格。",
      UnitClassConst.marshall: "可以使用两格内的友军棋子进行正常攻击。",
      UnitClassConst.berserker: "执行军事行动后，可以弃掉用于强化的棋子，并执行额外的军事行动。",
      UnitClassConst.warriorPriest: "在攻击或占领后可以立即抽取一枚硬币并使用。",
      UnitClassConst.footman: "可以在棋盘上部署最多两个棋子。这两个部署的棋子可以同时移动并采取行动。",
      UnitClassConst.scout: "可以部署在友军棋子旁边，不仅限于玩家的基地。",
      UnitClassConst.royalGuard: "受到伤害时，可以将棋子从雇佣区域送至坟场，而非棋盘。",
      UnitClassConst.blueRoyal: "法令",
      UnitClassConst.redRoyal: "法令",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.ru() {
    final map = {
      UnitClassConst.sword: "Может двигаться после атаки или занятия территории.",
      UnitClassConst.crossbow:
          "Может атаковать врагов, находящихся на прямой линии на расстоянии двух клеток.",
      UnitClassConst.knight: "Не получает урон от атак врагов без усиления.",
      UnitClassConst.archer:
          "Может атаковать врагов на расстоянии двух клеток. Не может атаковать соседних врагов.",
      UnitClassConst.cavalry: "Может атаковать после обычного движения.",
      UnitClassConst.lightCavalry: "Может передвигаться на две клетки.",
      UnitClassConst.lancer:
          "Может атаковать врагов на прямой линии на расстоянии двух или трех клеток. Не может атаковать соседних врагов.",
      UnitClassConst.pike: "Отвечает на атаку при получении урона.",
      UnitClassConst.mercenary:
          "При найме наемника может выполнять военные действия наемником на доске.",
      UnitClassConst.ensign: "Может перемещать соседнюю дружественную фигуру на одну клетку.",
      UnitClassConst.marshall:
          "Может совершить обычную атаку дружественной фигурой в радиусе двух клеток.",
      UnitClassConst.berserker:
          "После военного действия может сбросить фигуру, используемую для усиления, и выполнить дополнительное военное действие.",
      UnitClassConst.warriorPriest:
          "Может взять одну монету и использовать ее сразу после атаки или занятия территории.",
      UnitClassConst.footman:
          "Может развернуть до двух фигур на доске. Две развернутые фигуры могут двигаться и действовать одновременно.",
      UnitClassConst.scout:
          "Может быть развернут рядом с дружественными фигурами, не ограничиваясь базой игрока.",
      UnitClassConst.royalGuard:
          "При получении урона может отправить фигуру на кладбище из зоны найма вместо доски.",
      UnitClassConst.blueRoyal: "Указ",
      UnitClassConst.redRoyal: "Указ",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.uk() {
    final map = {
      UnitClassConst.sword: "Може рухатися після атаки або зайняття території.",
      UnitClassConst.crossbow: "Може атакувати ворогів, що знаходяться на двох клітинках впрямку.",
      UnitClassConst.knight: "Не отримує пошкоджень від атак ворогів без посилення.",
      UnitClassConst.archer:
          "Може атакувати ворогів на відстані двох клітинок. Не може атакувати сусідніх ворогів.",
      UnitClassConst.cavalry: "Може атакувати після звичайного руху.",
      UnitClassConst.lightCavalry: "Може рухатися на дві клітинки.",
      UnitClassConst.lancer:
          "Може атакувати ворогів на відстані двох або трьох клітинок по прямій. Не може атакувати сусідніх ворогів.",
      UnitClassConst.pike: "Контратакує при отриманні пошкодження.",
      UnitClassConst.mercenary:
          "При наймі наємника може виконувати військові дії наємником на дошці.",
      UnitClassConst.ensign: "Може пересувати сусідні дружні фігури на одну клітинку.",
      UnitClassConst.marshall:
          "Може виконати звичайну атаку дружньою фігурою в радіусі двох клітинок.",
      UnitClassConst.berserker:
          "Після військової дії може викинути фігуру, використану для посилення, та виконати додаткову військову дію.",
      UnitClassConst.warriorPriest:
          "Може взяти одну монету та використати її відразу після атаки або зайняття території.",
      UnitClassConst.footman:
          "Може розмістити до двох фігур на дошці. Дві розміщені фігури можуть рухатися та діяти одночасно.",
      UnitClassConst.scout:
          "Може бути розгорнутий поряд з дружніми фігурами, не обмежуючись базою гравця.",
      UnitClassConst.royalGuard:
          "При отриманні пошкодження може відправити фігуру на цвинтар з зони найму замість дошки.",
      UnitClassConst.blueRoyal: "Едікт",
      UnitClassConst.redRoyal: "Едікт",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.hr() {
    final map = {
      UnitClassConst.sword: "Može se kretati nakon napada ili zauzimanja.",
      UnitClassConst.crossbow:
          "Može napasti neprijatelje koji su dva kvadrata udaljeni u ravnoj liniji.",
      UnitClassConst.knight: "Ne prima štetu od napada nepojačanih neprijatelja.",
      UnitClassConst.archer:
          "Može napasti neprijatelje koji su dva kvadrata udaljeni. Ne može napasti neprijatelje u susjedstvu.",
      UnitClassConst.cavalry: "Može napasti nakon normalnog kretanja.",
      UnitClassConst.lightCavalry: "Može se pomaknuti dva kvadrata.",
      UnitClassConst.lancer:
          "Može napasti neprijatelje koji su dva ili tri kvadrata udaljeni u ravnoj liniji. Ne može napasti neprijatelje u susjedstvu.",
      UnitClassConst.pike: "Odgovara na napad kada primi štetu.",
      UnitClassConst.mercenary:
          "Kada unajmi plaćenika, može izvršiti vojnu akciju plaćenikom na ploči.",
      UnitClassConst.ensign: "Može pomaknuti susjedni prijateljski komad do jednog kvadrata.",
      UnitClassConst.marshall:
          "Može izvršiti normalan napad prijateljskim komadom unutar dva kvadrata.",
      UnitClassConst.berserker:
          "Nakon vojnog djelovanja, može odbaciti komad korišten za pojačanje i izvršiti dodatnu vojnu akciju.",
      UnitClassConst.warriorPriest:
          "Može izvući jedan novčić i odmah ga koristiti nakon napada ili zauzimanja.",
      UnitClassConst.footman:
          "Može rasporediti do dva komada na ploči. Dva raspoređena komada mogu se kretati i djelovati simultano.",
      UnitClassConst.scout:
          "Može se rasporediti pored prijateljskih komada, ne ograničavajući se na igračevu bazu.",
      UnitClassConst.royalGuard:
          "Kada prima štetu, može poslati komad na groblje iz područja zaposlenja umjesto s ploče.",
      UnitClassConst.blueRoyal: "Ukaz",
      UnitClassConst.redRoyal: "Ukaz",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.fr() {
    final map = {
      UnitClassConst.sword:
          "Peut effectuer un déplacement normal après une attaque ou une occupation.",
      UnitClassConst.crossbow:
          "Peut attaquer des ennemis qui sont à deux cases de distance en ligne droite.",
      UnitClassConst.knight: "Ne subit pas de dommages des attaques ennemies non améliorées.",
      UnitClassConst.archer:
          "Peut attaquer des ennemis qui sont à deux cases de distance. Ne peut pas attaquer les ennemis adjacents.",
      UnitClassConst.cavalry: "Peut attaquer après avoir effectué un mouvement normal.",
      UnitClassConst.lightCavalry: "Peut se déplacer de deux cases.",
      UnitClassConst.lancer:
          "Peut attaquer des ennemis qui sont à deux ou trois cases de distance en ligne droite. Ne peut pas attaquer les ennemis adjacents.",
      UnitClassConst.pike: "Riposte lorsqu'il subit des dommages.",
      UnitClassConst.mercenary:
          "Lors de l'embauche d'un mercenaire, peut effectuer une action militaire avec un mercenaire sur le plateau.",
      UnitClassConst.ensign: "Peut déplacer une pièce amicale adjacente d'une case.",
      UnitClassConst.marshall:
          "Peut effectuer une attaque normale avec une pièce amicale dans un rayon de deux cases.",
      UnitClassConst.berserker:
          "Après avoir effectué une action militaire, peut défausser une pièce utilisée pour l'amélioration et effectuer une action militaire supplémentaire.",
      UnitClassConst.warriorPriest:
          "Peut piocher une pièce et l'utiliser immédiatement après une attaque ou une occupation.",
      UnitClassConst.footman:
          "Peut déployer jusqu'à deux pièces sur le plateau. Les deux pièces déployées peuvent se déplacer et agir simultanément.",
      UnitClassConst.scout:
          "Peut être déployé à côté des pièces amies, pas seulement à la base du joueur.",
      UnitClassConst.royalGuard:
          "Lorsqu'il subit des dommages, peut envoyer la pièce au cimetière depuis la zone d'embauche au lieu du plateau.",
      UnitClassConst.blueRoyal: "Édit",
      UnitClassConst.redRoyal: "Édit",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitDescription.it() {
    final map = {
      UnitClassConst.sword: "Può eseguire un movimento normale dopo aver attaccato o occupato.",
      UnitClassConst.crossbow:
          "Può attaccare nemici che si trovano a due caselle di distanza in linea retta.",
      UnitClassConst.knight: "Non subisce danni da attacchi nemici non potenziati.",
      UnitClassConst.archer:
          "Può attaccare nemici che si trovano a due caselle di distanza. Non può attaccare nemici adiacenti.",
      UnitClassConst.cavalry: "Può attaccare dopo aver eseguito un movimento normale.",
      UnitClassConst.lightCavalry: "Può muoversi di due caselle.",
      UnitClassConst.lancer:
          "Può attaccare nemici che si trovano a due o tre caselle di distanza in linea retta. Non può attaccare nemici adiacenti.",
      UnitClassConst.pike: "Contrattacca quando subisce danni.",
      UnitClassConst.mercenary:
          "Quando assume un mercenario, può eseguire un'azione militare con un mercenario sulla scacchiera.",
      UnitClassConst.ensign: "Può muovere un pezzo amico adiacente fino a una casella.",
      UnitClassConst.marshall:
          "Può eseguire un attacco normale con un pezzo amico entro due caselle.",
      UnitClassConst.berserker:
          "Dopo aver eseguito un'azione militare, può scartare un pezzo utilizzato per il potenziamento e eseguire un'azione militare aggiuntiva.",
      UnitClassConst.warriorPriest:
          "Può prendere una moneta e usarla immediatamente dopo aver attaccato o occupato.",
      UnitClassConst.footman:
          "Può dispiegare fino a due pezzi sulla scacchiera. I due pezzi dispiegati possono muoversi e agire contemporaneamente.",
      UnitClassConst.scout:
          "Può essere dispiegato adiacente a pezzi amici, non limitato alla base del giocatore.",
      UnitClassConst.royalGuard:
          "Quando subisce danni, può inviare il pezzo al cimitero dall'area di assunzione invece che dalla scacchiera.",
      UnitClassConst.blueRoyal: "Editto",
      UnitClassConst.redRoyal: "Editto",
    };

    return UnitDescription(
      unitClass: (unitId) => map[unitId],
    );
  }
}
