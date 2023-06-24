import 'package:warchest_dojo/const/unit_class_const.dart';

class UnitCharacteristic {
  final Function(String?) unitClass;

  UnitCharacteristic({
    required this.unitClass,
  });

  factory UnitCharacteristic.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return UnitCharacteristic.ja();
      case 'en':
        return UnitCharacteristic.en();
      case 'zh':
        return UnitCharacteristic.zh();
      case 'ko':
        return UnitCharacteristic.ko();
      case 'ru':
        return UnitCharacteristic.ru();
      case 'uk':
        return UnitCharacteristic.uk();
      case 'hr':
        return UnitCharacteristic.hr();
      case 'fr':
        return UnitCharacteristic.fr();
      case 'it':
        return UnitCharacteristic.it();
      default:
        return UnitCharacteristic.en();
    }
  }

  factory UnitCharacteristic.ja() {
    final map = {
      UnitClassConst.sword: "なし",
      UnitClassConst.crossbow: "なし",
      UnitClassConst.knight: "鉄壁：強化されていない敵から攻撃を受け付けない。",
      UnitClassConst.archer: "禁則：隣接した敵を攻撃できない。",
      UnitClassConst.cavalry: "なし",
      UnitClassConst.lightCavalry: "迅速：２マス移動できる。",
      UnitClassConst.lancer: "禁則：隣接した敵を攻撃できない。\n"
          "攻撃時、相手の駒を最大で２つ墓場へ送る。",
      UnitClassConst.pike: "反撃：攻撃してきた相手が隣接している場合、相手の駒をひとつ盤上から墓場へ送る。",
      UnitClassConst.mercenary: "なし",
      UnitClassConst.ensign: "なし",
      UnitClassConst.marshall: "なし",
      UnitClassConst.berserker: "なし",
      UnitClassConst.warriorPriest: "なし",
      UnitClassConst.footman: "援軍：展開する際は手札ではなく雇用場から盤上へ駒を配置できる。\n"
          "大軍：盤上に２つまで駒を展開できる。",
      UnitClassConst.scout: "潜入：展開する際、自陣営の拠点に限らず味方の隣マスであればどこでも配置できる。",
      UnitClassConst.royalGuard: "死守：攻撃を受けた際、駒を盤上ではなく雇用場から墓場へ送れる。",
      UnitClassConst.blueRoyal: "なし",
      UnitClassConst.redRoyal: "なし",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.en() {
    final map = {
      UnitClassConst.sword: "None",
      UnitClassConst.crossbow: "None",
      UnitClassConst.knight: "Iron Wall: Does not take damage from unenhanced enemy attacks.",
      UnitClassConst.archer: "Restriction: Cannot attack adjacent enemies.",
      UnitClassConst.cavalry: "None",
      UnitClassConst.lightCavalry: "Swift: Can move two squares.",
      UnitClassConst.lancer: "Restriction: Cannot attack adjacent enemies.\n"
          "On attack, can send up to two of the opponent's pieces to the graveyard.",
      UnitClassConst.pike:
          "Counterattack: If the opponent who attacked is adjacent, can send one of their pieces to the graveyard.",
      UnitClassConst.mercenary: "None",
      UnitClassConst.ensign: "None",
      UnitClassConst.marshall: "None",
      UnitClassConst.berserker: "None",
      UnitClassConst.warriorPriest: "None",
      UnitClassConst.footman:
          "Reinforcements: When deployed, can be placed on the board from the employment area instead of from the hand.\n"
              "Grand Army: Can deploy up to two pieces on the board.",
      UnitClassConst.scout:
          "Infiltration: When deployed, can be placed anywhere adjacent to friendly pieces, not limited to the player's home base.",
      UnitClassConst.royalGuard:
          "Defend to Death: When taking damage, can send the piece to the graveyard from the employment area instead of the board.",
      UnitClassConst.blueRoyal: "None",
      UnitClassConst.redRoyal: "None",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.zh() {
    final map = {
      UnitClassConst.sword: "無",
      UnitClassConst.crossbow: "無",
      UnitClassConst.knight: "鐵牆: 不受未強化敵人攻擊的傷害。",
      UnitClassConst.archer: "限制: 不能攻擊相鄰的敵人。",
      UnitClassConst.cavalry: "無",
      UnitClassConst.lightCavalry: "快速: 可移動兩個方格。",
      UnitClassConst.lancer: "限制: 不能攻擊相鄰的敵人。\n"
          "攻擊時，最多可將對手的兩個棋子送入墳場。",
      UnitClassConst.pike: "反擊: 如果攻擊的對手相鄰，可以將他們的一個棋子送入墳場。",
      UnitClassConst.mercenary: "無",
      UnitClassConst.ensign: "無",
      UnitClassConst.marshall: "無",
      UnitClassConst.berserker: "無",
      UnitClassConst.warriorPriest: "無",
      UnitClassConst.footman: "增援: 部署時，可以從僱用區而不是從手上放置在棋盤上。\n"
          "大軍: 可以在棋盤上部署最多兩個棋子。",
      UnitClassConst.scout: "滲透: 部署時，可以放置在友方棋子相鄰的任何地方，不僅限於玩家的基地。",
      UnitClassConst.royalGuard: "捍衛至死: 受到傷害時，可以將棋子從僱用區而不是棋盤送入墳場。",
      UnitClassConst.blueRoyal: "無",
      UnitClassConst.redRoyal: "無",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.ko() {
    final map = {
      UnitClassConst.sword: "없음",
      UnitClassConst.crossbow: "없음",
      UnitClassConst.knight: "철벽: 강화되지 않은 적의 공격에서 피해를 입지 않습니다.",
      UnitClassConst.archer: "제한: 인접한 적을 공격할 수 없습니다.",
      UnitClassConst.cavalry: "없음",
      UnitClassConst.lightCavalry: "신속: 두 칸을 이동할 수 있습니다.",
      UnitClassConst.lancer: "제한: 인접한 적을 공격할 수 없습니다.\n"
          "공격 시, 상대의 최대 두 개의 말을 무덤으로 보낼 수 있습니다.",
      UnitClassConst.pike: "반격: 공격한 상대가 인접해 있으면 그들의 한 개의 말을 무덤으로 보낼 수 있습니다.",
      UnitClassConst.mercenary: "없음",
      UnitClassConst.ensign: "없음",
      UnitClassConst.marshall: "없음",
      UnitClassConst.berserker: "없음",
      UnitClassConst.warriorPriest: "없음",
      UnitClassConst.footman: "보강: 배치할 때, 손에서가 아닌 고용 지역에서 보드에 놓을 수 있습니다.\n"
          "대군: 보드에 최대 두 개의 말을 배치할 수 있습니다.",
      UnitClassConst.scout: "침투: 배치할 때, 친절한 말이 인접한 어디에서나 놓을 수 있으며, 플레이어의 홈 베이스로 제한되지 않습니다.",
      UnitClassConst.royalGuard: "죽음까지 방어: 피해를 입을 때, 보드가 아닌 고용 지역에서 말을 무덤으로 보낼 수 있습니다.",
      UnitClassConst.blueRoyal: "없음",
      UnitClassConst.redRoyal: "없음",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.ru() {
    final map = {
      UnitClassConst.sword: "Отсутствует",
      UnitClassConst.crossbow: "Отсутствует",
      UnitClassConst.knight: "Железная стена: не получает урон от атак врага без усиления.",
      UnitClassConst.archer: "Ограничение: не может атаковать соседних врагов.",
      UnitClassConst.cavalry: "Отсутствует",
      UnitClassConst.lightCavalry: "Быстрота: может перемещаться на две клетки.",
      UnitClassConst.lancer: "Ограничение: не может атаковать соседних врагов.\n"
          "При атаке может отправить до двух фигур противника на кладбище.",
      UnitClassConst.pike:
          "Контратака: если атакующий противник находится рядом, может отправить одну из его фигур на кладбище.",
      UnitClassConst.mercenary: "Отсутствует",
      UnitClassConst.ensign: "Отсутствует",
      UnitClassConst.marshall: "Отсутствует",
      UnitClassConst.berserker: "Отсутствует",
      UnitClassConst.warriorPriest: "Отсутствует",
      UnitClassConst.footman:
          "Подкрепления: при развертывании можно разместить на доске из зоны найма, а не из руки.\n"
              "Большая армия: можно развернуть на доске до двух фигур.",
      UnitClassConst.scout:
          "Инфильтрация: при развертывании можно разместить где угодно рядом с дружественными фигурами, не ограничиваясь базой игрока.",
      UnitClassConst.royalGuard:
          "Оборона до смерти: при получении урона можно отправить фигуру на кладбище из зоны найма, а не с доски.",
      UnitClassConst.blueRoyal: "Отсутствует",
      UnitClassConst.redRoyal: "Отсутствует",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.uk() {
    final map = {
      UnitClassConst.sword: "Відсутній",
      UnitClassConst.crossbow: "Відсутній",
      UnitClassConst.knight: "Залізний щит: не отримує пошкоджень від атак ворога без підсилення.",
      UnitClassConst.archer: "Обмеження: не може атакувати сусідніх ворогів.",
      UnitClassConst.cavalry: "Відсутній",
      UnitClassConst.lightCavalry: "Швидкість: може переміщатися на дві клітинки.",
      UnitClassConst.lancer: "Обмеження: не може атакувати сусідніх ворогів.\n"
          "Під час атаки може відправити до двох фігур противника на цвинтар.",
      UnitClassConst.pike:
          "Контратака: якщо атакуючий ворог знаходиться поруч, може відправити одну з його фігур на цвинтар.",
      UnitClassConst.mercenary: "Відсутній",
      UnitClassConst.ensign: "Відсутній",
      UnitClassConst.marshall: "Відсутній",
      UnitClassConst.berserker: "Відсутній",
      UnitClassConst.warriorPriest: "Відсутній",
      UnitClassConst.footman:
          "Підкріплення: при розгортанні можна розмістити на дошці з зони найму, а не з руки.\n"
              "Велика армія: можна розгорнути на дошці до двох фігур.",
      UnitClassConst.scout:
          "Інфільтрація: при розгортанні можна розмістити будь-де поряд з дружніми фігурами, не обмежуючись базою гравця.",
      UnitClassConst.royalGuard:
          "Оборона до смерті: при отриманні пошкоджень можна відправити фігуру на цвинтар з зони найму, а не з дошки.",
      UnitClassConst.blueRoyal: "Відсутній",
      UnitClassConst.redRoyal: "Відсутній",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.hr() {
    final map = {
      UnitClassConst.sword: "Nema",
      UnitClassConst.crossbow: "Nema",
      UnitClassConst.knight: "Željezni zid: Ne prima štetu od napada nepoboljšanog neprijatelja.",
      UnitClassConst.archer: "Ograničenje: Ne može napasti susjedne neprijatelje.",
      UnitClassConst.cavalry: "Nema",
      UnitClassConst.lightCavalry: "Brz: Može se pomaknuti dva kvadrata.",
      UnitClassConst.lancer: "Ograničenje: Ne može napasti susjedne neprijatelje.\n"
          "Prilikom napada, može poslati do dva protivnička komada na groblje.",
      UnitClassConst.pike:
          "Protunapad: Ako je protivnik koji je napao susjedan, može poslati jedan njegov komad na groblje.",
      UnitClassConst.mercenary: "Nema",
      UnitClassConst.ensign: "Nema",
      UnitClassConst.marshall: "Nema",
      UnitClassConst.berserker: "Nema",
      UnitClassConst.warriorPriest: "Nema",
      UnitClassConst.footman:
          "Pojačanja: Kada se raspoređuje, može se postaviti na ploču iz područja zaposlenja umjesto iz ruke.\n"
              "Velika vojska: Može rasporediti do dva komada na ploči.",
      UnitClassConst.scout:
          "Infiltracija: Kada se raspoređuje, može se postaviti bilo gdje pored prijateljskih komada, ne ograničavajući se na igračevu bazu.",
      UnitClassConst.royalGuard:
          "Obrana do smrti: Kada prima štetu, može poslati komad na groblje iz područja zaposlenja umjesto s ploče.",
      UnitClassConst.blueRoyal: "Nema",
      UnitClassConst.redRoyal: "Nema",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.fr() {
    final map = {
      UnitClassConst.sword: "Aucun",
      UnitClassConst.crossbow: "Aucun",
      UnitClassConst.knight:
          "Mur de fer: Ne subit pas de dommages des attaques non améliorées de l'ennemi.",
      UnitClassConst.archer: "Restriction: Ne peut pas attaquer les ennemis adjacents.",
      UnitClassConst.cavalry: "Aucun",
      UnitClassConst.lightCavalry: "Rapide: Peut se déplacer de deux cases.",
      UnitClassConst.lancer: "Restriction: Ne peut pas attaquer les ennemis adjacents.\n"
          "En attaque, peut envoyer jusqu'à deux pièces de l'adversaire au cimetière.",
      UnitClassConst.pike:
          "Contre-attaque: Si l'adversaire qui a attaqué est adjacent, peut envoyer une de ses pièces au cimetière.",
      UnitClassConst.mercenary: "Aucun",
      UnitClassConst.ensign: "Aucun",
      UnitClassConst.marshall: "Aucun",
      UnitClassConst.berserker: "Aucun",
      UnitClassConst.warriorPriest: "Aucun",
      UnitClassConst.footman:
          "Renforts: Lors de la mise en jeu, peut être placé sur le plateau à partir de la zone d'emploi au lieu de la main.\n"
              "Grande Armée: Peut déployer jusqu'à deux pièces sur le plateau.",
      UnitClassConst.scout:
          "Infiltration: Lors du déploiement, peut être placé n'importe où adjacent aux pièces amies, sans être limité à la base du joueur.",
      UnitClassConst.royalGuard:
          "Défendre à mort: Lorsqu'il subit des dommages, peut envoyer la pièce au cimetière depuis la zone d'emploi plutôt que du plateau.",
      UnitClassConst.blueRoyal: "Aucun",
      UnitClassConst.redRoyal: "Aucun",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitCharacteristic.it() {
    final map = {
      UnitClassConst.sword: "Nessuno",
      UnitClassConst.crossbow: "Nessuno",
      UnitClassConst.knight: "Muro di Ferro: Non subisce danni da attacchi nemici non potenziati.",
      UnitClassConst.archer: "Restrizione: Non può attaccare nemici adiacenti.",
      UnitClassConst.cavalry: "Nessuno",
      UnitClassConst.lightCavalry: "Veloce: Può muoversi di due caselle.",
      UnitClassConst.lancer: "Restrizione: Non può attaccare nemici adiacenti.\n"
          "In attacco, può mandare fino a due pezzi dell'avversario nel cimitero.",
      UnitClassConst.pike:
          "Controattacco: Se l'avversario che ha attaccato è adiacente, può mandare uno dei suoi pezzi nel cimitero.",
      UnitClassConst.mercenary: "Nessuno",
      UnitClassConst.ensign: "Nessuno",
      UnitClassConst.marshall: "Nessuno",
      UnitClassConst.berserker: "Nessuno",
      UnitClassConst.warriorPriest: "Nessuno",
      UnitClassConst.footman:
          "Rinforzi: Quando viene dispiegato, può essere posto sulla scacchiera dall'area di assunzione invece che dalla mano.\n"
              "Grande Esercito: Può dispiegare fino a due pezzi sulla scacchiera.",
      UnitClassConst.scout:
          "Infiltrazione: Quando viene dispiegato, può essere posto ovunque adiacente ai pezzi amici, non limitato alla base del giocatore.",
      UnitClassConst.royalGuard:
          "Difendi a Morte: Quando subisce danni, può mandare il pezzo nel cimitero dall'area di assunzione invece che dalla scacchiera.",
      UnitClassConst.blueRoyal: "Nessuno",
      UnitClassConst.redRoyal: "Nessuno",
    };

    return UnitCharacteristic(
      unitClass: (unitId) => map[unitId],
    );
  }
}
