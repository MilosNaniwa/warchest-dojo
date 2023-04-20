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
}
