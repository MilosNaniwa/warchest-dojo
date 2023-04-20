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
  final String version0_0_5;
  final String version0_0_4;
  final String version0_0_3;
  final String version0_0_2;
  final String version0_0_1;

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
    required this.version0_0_5,
    required this.version0_0_4,
    required this.version0_0_3,
    required this.version0_0_2,
    required this.version0_0_1,
  });

  factory DraftPageMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return DraftPageMessage.ja();
      case 'en':
        return DraftPageMessage.en();
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
        version0_0_5: 'CPUの思考回路を調整。',
        version0_0_4: 'CPUの思考回路を調整。',
        version0_0_3: 'CPUの思考回路を調整。',
        version0_0_2: 'CPUの思考回路を調整。バグを修正。',
        version0_0_1: '公開',
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
        version0_0_5: 'Tweaked AI Algorithm.',
        version0_0_4: 'Tweaked AI Algorithm.',
        version0_0_3: 'Tweaked AI Algorithm. Fixed bug.',
        version0_0_2: 'Fixed bug.',
        version0_0_1: 'Released',
      );
}
