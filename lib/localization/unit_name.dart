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
      case 'zh':
        return UnitName.zh();
      case 'ko':
        return UnitName.ko();
      case 'ru':
        return UnitName.ru();
      case 'uk':
        return UnitName.uk();
      case 'hr':
        return UnitName.hr();
      case 'fr':
        return UnitName.fr();
      case 'it':
        return UnitName.it();
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

  factory UnitName.zh() {
    final map = {
      UnitClassConst.sword: "剑士",
      UnitClassConst.crossbow: "弩手",
      UnitClassConst.knight: "骑士",
      UnitClassConst.archer: "弓箭手",
      UnitClassConst.cavalry: "骑兵",
      UnitClassConst.lightCavalry: "轻骑兵",
      UnitClassConst.lancer: "长矛手",
      UnitClassConst.pike: "枪兵",
      UnitClassConst.mercenary: "雇佣兵",
      UnitClassConst.ensign: "旗手",
      UnitClassConst.marshall: "元帅",
      UnitClassConst.berserker: "狂战士",
      UnitClassConst.warriorPriest: "战士祭司",
      UnitClassConst.footman: "步兵",
      UnitClassConst.scout: "侦查兵",
      UnitClassConst.royalGuard: "皇家卫士",
      UnitClassConst.blueRoyal: "皇家硬币",
      UnitClassConst.redRoyal: "皇家硬币",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.ko() {
    final map = {
      UnitClassConst.sword: "검사",
      UnitClassConst.crossbow: "석궁수",
      UnitClassConst.knight: "기사",
      UnitClassConst.archer: "궁수",
      UnitClassConst.cavalry: "기병",
      UnitClassConst.lightCavalry: "경기병",
      UnitClassConst.lancer: "창기병",
      UnitClassConst.pike: "장창병",
      UnitClassConst.mercenary: "용병",
      UnitClassConst.ensign: "기장",
      UnitClassConst.marshall: "장군",
      UnitClassConst.berserker: "광전사",
      UnitClassConst.warriorPriest: "전사 사제",
      UnitClassConst.footman: "보병",
      UnitClassConst.scout: "정찰병",
      UnitClassConst.royalGuard: "왕실 수호병",
      UnitClassConst.blueRoyal: "왕실 동전",
      UnitClassConst.redRoyal: "왕실 동전",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.ru() {
    final map = {
      UnitClassConst.sword: "Мечник",
      UnitClassConst.crossbow: "Арбалетчик",
      UnitClassConst.knight: "Рыцарь",
      UnitClassConst.archer: "Лучник",
      UnitClassConst.cavalry: "Кавалерист",
      UnitClassConst.lightCavalry: "Лёгкая кавалерия",
      UnitClassConst.lancer: "Копейщик",
      UnitClassConst.pike: "Пикинер",
      UnitClassConst.mercenary: "Наёмник",
      UnitClassConst.ensign: "Штандартист",
      UnitClassConst.marshall: "Маршал",
      UnitClassConst.berserker: "Берсерк",
      UnitClassConst.warriorPriest: "Воин-священник",
      UnitClassConst.footman: "Пехотинец",
      UnitClassConst.scout: "Разведчик",
      UnitClassConst.royalGuard: "Королевская гвардия",
      UnitClassConst.blueRoyal: "Королевская монета",
      UnitClassConst.redRoyal: "Королевская монета",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.uk() {
    final map = {
      UnitClassConst.sword: "Мечник",
      UnitClassConst.crossbow: "Арбалетник",
      UnitClassConst.knight: "Рицар",
      UnitClassConst.archer: "Лучник",
      UnitClassConst.cavalry: "Кавалеріст",
      UnitClassConst.lightCavalry: "Легка кавалерія",
      UnitClassConst.lancer: "Копійник",
      UnitClassConst.pike: "Пікінер",
      UnitClassConst.mercenary: "Найманець",
      UnitClassConst.ensign: "Прапорець",
      UnitClassConst.marshall: "Маршал",
      UnitClassConst.berserker: "Берсерк",
      UnitClassConst.warriorPriest: "Воїн-священник",
      UnitClassConst.footman: "Піхотинець",
      UnitClassConst.scout: "Розвідник",
      UnitClassConst.royalGuard: "Королівська гвардія",
      UnitClassConst.blueRoyal: "Королівська монета",
      UnitClassConst.redRoyal: "Королівська монета",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.hr() {
    final map = {
      UnitClassConst.sword: "Mačevalac",
      UnitClassConst.crossbow: "Strijelac s arbalestom",
      UnitClassConst.knight: "Vitez",
      UnitClassConst.archer: "Strijelac",
      UnitClassConst.cavalry: "Konjaništvo",
      UnitClassConst.lightCavalry: "Lako konjaništvo",
      UnitClassConst.lancer: "Kopljanik",
      UnitClassConst.pike: "Pikeman",
      UnitClassConst.mercenary: "Plaćenik",
      UnitClassConst.ensign: "Zastavnik",
      UnitClassConst.marshall: "Maršal",
      UnitClassConst.berserker: "Berserker",
      UnitClassConst.warriorPriest: "Ratnik svećenik",
      UnitClassConst.footman: "Pješak",
      UnitClassConst.scout: "Izviđač",
      UnitClassConst.royalGuard: "Kraljevska garda",
      UnitClassConst.blueRoyal: "Kraljevski novčić",
      UnitClassConst.redRoyal: "Kraljevski novčić",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.fr() {
    final map = {
      UnitClassConst.sword: "Épéiste",
      UnitClassConst.crossbow: "Arbalétrier",
      UnitClassConst.knight: "Chevalier",
      UnitClassConst.archer: "Archer",
      UnitClassConst.cavalry: "Cavalerie",
      UnitClassConst.lightCavalry: "Cavalerie légère",
      UnitClassConst.lancer: "Lancier",
      UnitClassConst.pike: "Piquier",
      UnitClassConst.mercenary: "Mercenaire",
      UnitClassConst.ensign: "Enseigne",
      UnitClassConst.marshall: "Maréchal",
      UnitClassConst.berserker: "Berserker",
      UnitClassConst.warriorPriest: "Prêtre guerrier",
      UnitClassConst.footman: "Fantassin",
      UnitClassConst.scout: "Éclaireur",
      UnitClassConst.royalGuard: "Garde royale",
      UnitClassConst.blueRoyal: "Pièce royale",
      UnitClassConst.redRoyal: "Pièce royale",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }

  factory UnitName.it() {
    final map = {
      UnitClassConst.sword: "Spadaccino",
      UnitClassConst.crossbow: "Balestriere",
      UnitClassConst.knight: "Cavaliere",
      UnitClassConst.archer: "Arciere",
      UnitClassConst.cavalry: "Cavalleria",
      UnitClassConst.lightCavalry: "Cavalleria leggera",
      UnitClassConst.lancer: "Lanciere",
      UnitClassConst.pike: "Picchiero",
      UnitClassConst.mercenary: "Mercenario",
      UnitClassConst.ensign: "Insegna",
      UnitClassConst.marshall: "Maresciallo",
      UnitClassConst.berserker: "Berserker",
      UnitClassConst.warriorPriest: "Prete guerriero",
      UnitClassConst.footman: "Fante",
      UnitClassConst.scout: "Scout",
      UnitClassConst.royalGuard: "Guardia reale",
      UnitClassConst.blueRoyal: "Moneta reale",
      UnitClassConst.redRoyal: "Moneta reale",
    };

    return UnitName(
      unitClass: (unitId) => map[unitId],
    );
  }
}
