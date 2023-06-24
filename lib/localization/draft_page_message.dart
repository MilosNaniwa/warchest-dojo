class DraftPageMessage {
  final String draft;
  final String player;
  final String computer;
  final String doYouWantShuffle;
  final String yes;
  final String no;
  final String selecting;
  final String select;
  final String close;
  final String tactic;
  final String characteristic;
  final String cpuCannotSelect;

  DraftPageMessage({
    required this.draft,
    required this.player,
    required this.computer,
    required this.doYouWantShuffle,
    required this.yes,
    required this.no,
    required this.selecting,
    required this.select,
    required this.close,
    required this.tactic,
    required this.characteristic,
    required this.cpuCannotSelect,
  });

  factory DraftPageMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return DraftPageMessage.ja();
      case 'en':
        return DraftPageMessage.en();
      case 'zh':
        return DraftPageMessage.zh();
      case 'ko':
        return DraftPageMessage.ko();
      case 'ru':
        return DraftPageMessage.ru();
      case 'uk':
        return DraftPageMessage.uk();
      case 'hr':
        return DraftPageMessage.hr();
      case 'fr':
        return DraftPageMessage.fr();
      case 'it':
        return DraftPageMessage.it();
      default:
        return DraftPageMessage.en();
    }
  }

  factory DraftPageMessage.ja() => DraftPageMessage(
        draft: "兵種選択",
        player: 'プレイヤー（青軍） {count} / 4',
        computer: 'コンピューター（赤軍） {count} / 4',
        doYouWantShuffle: 'シャッフルしてよろしいですか？',
        yes: 'はい',
        no: 'いいえ',
        selecting: '[選択中]',
        select: '選択',
        close: '閉じる',
        tactic: '戦術',
        characteristic: '特性',
        cpuCannotSelect: '※CPUは選択できません。',
      );

  factory DraftPageMessage.en() => DraftPageMessage(
        draft: "Draft",
        player: 'Player(Blue) {count} / 4',
        computer: 'Computer(Red) {count} / 4',
        doYouWantShuffle: 'Do you want to shuffle?',
        yes: 'Yes',
        no: 'No',
        selecting: '[Selecting]',
        select: "Select",
        close: 'Close',
        tactic: 'Tactic',
        characteristic: 'Characteristic',
        cpuCannotSelect: '* AI cannot select this unit.',
      );

  factory DraftPageMessage.zh() => DraftPageMessage(
        draft: "草稿",
        player: '玩家(蓝色) {count} / 4',
        computer: '电脑(红色) {count} / 4',
        doYouWantShuffle: '你要洗牌吗？',
        yes: '是的',
        no: '不是',
        selecting: '[正在选择]',
        select: "选择",
        close: '关闭',
        tactic: '策略',
        characteristic: '特性',
        cpuCannotSelect: '* AI无法选择此单元。',
      );

  factory DraftPageMessage.ko() => DraftPageMessage(
        draft: "드래프트",
        player: '플레이어(블루) {count} / 4',
        computer: '컴퓨터(레드) {count} / 4',
        doYouWantShuffle: '셔플하시겠습니까?',
        yes: '예',
        no: '아니요',
        selecting: '[선택 중]',
        select: "선택",
        close: '닫기',
        tactic: '전략',
        characteristic: '특성',
        cpuCannotSelect: '* AI는 이 유닛을 선택할 수 없습니다.',
      );

  factory DraftPageMessage.ru() => DraftPageMessage(
        draft: "Черновик",
        player: 'Игрок(Синий) {count} / 4',
        computer: 'Компьютер(Красный) {count} / 4',
        doYouWantShuffle: 'Хотите перемешать?',
        yes: 'Да',
        no: 'Нет',
        selecting: '[Выбор]',
        select: "Выбрать",
        close: 'Закрыть',
        tactic: 'Тактика',
        characteristic: 'Характеристика',
        cpuCannotSelect: '* AI не может выбрать этот блок.',
      );

  factory DraftPageMessage.uk() => DraftPageMessage(
        draft: "Проект",
        player: 'Гравець(Синій) {count} / 4',
        computer: 'Ком\'ютер(Червоний) {count} / 4',
        doYouWantShuffle: 'Ви хочете змішати?',
        yes: 'Так',
        no: 'Ні',
        selecting: '[Вибір]',
        select: "Вибрати",
        close: 'Закрити',
        tactic: 'Тактика',
        characteristic: 'Характеристика',
        cpuCannotSelect: '* AI не може вибрати цей блок.',
      );

  factory DraftPageMessage.hr() => DraftPageMessage(
        draft: "Skica",
        player: 'Igrač(Plavo) {count} / 4',
        computer: 'Računalo(Crveno) {count} / 4',
        doYouWantShuffle: 'Želite li promiješati?',
        yes: 'Da',
        no: 'Ne',
        selecting: '[Odabir]',
        select: "Odaberite",
        close: 'Zatvori',
        tactic: 'Taktika',
        characteristic: 'Karakteristika',
        cpuCannotSelect: '* AI ne može odabrati ovu jedinicu.',
      );

  factory DraftPageMessage.fr() => DraftPageMessage(
        draft: "Brouillon",
        player: 'Joueur(Bleu) {count} / 4',
        computer: 'Ordinateur(Rouge) {count} / 4',
        doYouWantShuffle: 'Voulez-vous mélanger?',
        yes: 'Oui',
        no: 'Non',
        selecting: '[En sélection]',
        select: "Sélectionner",
        close: 'Fermer',
        tactic: 'Tactique',
        characteristic: 'Caractéristique',
        cpuCannotSelect: '* L\'IA ne peut pas sélectionner cette unité.',
      );

  factory DraftPageMessage.it() => DraftPageMessage(
        draft: "Bozza",
        player: 'Giocatore(Blu) {count} / 4',
        computer: 'Computer(Rosso) {count} / 4',
        doYouWantShuffle: 'Vuoi mescolare?',
        yes: 'Sì',
        no: 'No',
        selecting: '[Selezionando]',
        select: "Seleziona",
        close: 'Chiudi',
        tactic: 'Tattica',
        characteristic: 'Caratteristica',
        cpuCannotSelect: '* L\'IA non può selezionare questa unità.',
      );
}
