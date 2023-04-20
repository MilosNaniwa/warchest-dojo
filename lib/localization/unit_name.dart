import 'package:warchest_dojo/const/unit_class_const.dart';

class UnitName {
  final Function(String?) unitClass;

  UnitName({
    required this.unitClass,
  });

  factory UnitName.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return UnitName.ja();
      case 'en':
        return UnitName.en();
      default:
        return UnitName.en();
    }
  }

  factory UnitName.ja() {
    final map = {
      UnitClassConst.sword: "剣兵",
      UnitClassConst.crossbow: "弩兵",
      UnitClassConst.knight: "重装兵",
      UnitClassConst.archer: "弓兵",
      UnitClassConst.cavalry: "騎兵",
      UnitClassConst.lightCavalry: "軽騎兵",
      UnitClassConst.lancer: "突撃騎兵",
      UnitClassConst.pike: "槍兵",
      UnitClassConst.mercenary: "傭兵",
      UnitClassConst.ensign: "旗兵",
      UnitClassConst.marshall: "総帥",
      UnitClassConst.berserker: "狂戦士",
      UnitClassConst.warriorPriest: "僧兵",
      UnitClassConst.footman: "従兵",
      UnitClassConst.scout: "偵察兵",
      UnitClassConst.royalGuard: "衛兵",
      UnitClassConst.blueRoyal: "勅令",
      UnitClassConst.redRoyal: "勅令",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.en() {
    final map = {
      UnitClassConst.sword: "Swordman",
      UnitClassConst.crossbow: "Crossbowman",
      UnitClassConst.knight: "Knight",
      UnitClassConst.archer: "Archer",
      UnitClassConst.cavalry: "Cavalry",
      UnitClassConst.lightCavalry: "Light Cavalry",
      UnitClassConst.lancer: "Lancer",
      UnitClassConst.pike: "Pikeman",
      UnitClassConst.mercenary: "Mercenary",
      UnitClassConst.ensign: "Ensign",
      UnitClassConst.marshall: "Marshall",
      UnitClassConst.berserker: "Berserker",
      UnitClassConst.warriorPriest: "Warrior Priest",
      UnitClassConst.footman: "Footman",
      UnitClassConst.scout: "Scout",
      UnitClassConst.royalGuard: "Royal Guard",
      UnitClassConst.blueRoyal: "Royal Coin",
      UnitClassConst.redRoyal: "Royal Coin",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }
}
