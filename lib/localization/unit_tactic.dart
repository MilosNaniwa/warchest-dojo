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
}
