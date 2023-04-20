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
}
