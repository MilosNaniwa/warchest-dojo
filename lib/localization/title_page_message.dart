class TitlePageMessage {
  final String titleWarChestDojo;
  final String startTraining;
  final String howToPlay;
  final String feedback;
  final String faq;
  final String feedbackUrl;
  final String supportCreator;
  final String debugMode;
  final String close;
  final String difficulty;
  final String illustrationOfUnit;
  final String chatMode;
  final String chatModeDescription;
  final String on;
  final String off;
  final String kanji;
  final String illustration;
  final String confirm;
  final String chief;
  final String sergeant;
  final String shogun;
  final String prototype;
  final String prototypeNotification;
  final String draftMode;
  final String random;
  final String custom;
  final String recentUpdate;
  final String version0_4_2;
  final String version0_4_1;
  final String version0_4_0;
  final String version0_3_3;
  final String version0_3_2;
  final String version0_3_1;
  final String version0_3_0;
  final String version0_2_4;
  final String version0_2_3;
  final String version0_2_2;
  final String version0_2_1;
  final String version0_2_0;
  final String version0_1_2;
  final String version0_1_1;
  final String version0_1_0;
  final String version0_0_10;
  final String version0_0_9;
  final String version0_0_8;
  final String version0_0_7;
  final String version0_0_6;
  final String version0_0_5;
  final String version0_0_4;
  final String version0_0_3;
  final String version0_0_2;
  final String version0_0_1;

  TitlePageMessage({
    required this.titleWarChestDojo,
    required this.startTraining,
    required this.howToPlay,
    required this.feedback,
    required this.faq,
    required this.feedbackUrl,
    required this.supportCreator,
    required this.debugMode,
    required this.close,
    required this.difficulty,
    required this.illustrationOfUnit,
    required this.chatMode,
    required this.chatModeDescription,
    required this.on,
    required this.off,
    required this.kanji,
    required this.illustration,
    required this.confirm,
    required this.chief,
    required this.sergeant,
    required this.shogun,
    required this.prototype,
    required this.prototypeNotification,
    required this.draftMode,
    required this.random,
    required this.custom,
    required this.recentUpdate,
    required this.version0_4_2,
    required this.version0_4_1,
    required this.version0_4_0,
    required this.version0_3_3,
    required this.version0_3_2,
    required this.version0_3_1,
    required this.version0_3_0,
    required this.version0_2_4,
    required this.version0_2_3,
    required this.version0_2_2,
    required this.version0_2_1,
    required this.version0_2_0,
    required this.version0_1_2,
    required this.version0_1_1,
    required this.version0_1_0,
    required this.version0_0_10,
    required this.version0_0_9,
    required this.version0_0_8,
    required this.version0_0_7,
    required this.version0_0_6,
    required this.version0_0_5,
    required this.version0_0_4,
    required this.version0_0_3,
    required this.version0_0_2,
    required this.version0_0_1,
  });

  factory TitlePageMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return TitlePageMessage.ja();
      case 'en':
        return TitlePageMessage.en();
      default:
        return TitlePageMessage.en();
    }
  }

  factory TitlePageMessage.ja() => TitlePageMessage(
        titleWarChestDojo: "戦箱道場",
        startTraining: '訓練開始',
        howToPlay: '遊戯方法',
        feedback: '御意見箱',
        faq: '一問一答',
        feedbackUrl:
            'https://docs.google.com/forms/d/e/1FAIpQLSeAsPds2uEYpotk2gaEj-XLExBPlAVPiahuqAZcPDLQE4uC9g/viewform',
        debugMode: '開発モード',
        supportCreator: '作者支援',
        close: '閉じる',
        difficulty: '難易度',
        illustrationOfUnit: '駒の絵柄',
        chatMode: 'チャットモード（試験運用）',
        chatModeDescription: '※一定数の手番ごとにAIが喋ります。',
        on: '有効',
        off: '無効',
        kanji: '漢字',
        illustration: '絵',
        chief: '兵長 ★',
        sergeant: '軍曹 ★★',
        shogun: '将軍 ★★★',
        prototype: '試作品 ???（試運用）',
        prototypeNotification: '※AIの計算量により動作が重くなる場合があります。',
        draftMode: '兵種選択',
        random: 'ランダム',
        custom: 'カスタム',
        confirm: '次へ',
        recentUpdate: '更新情報',
        version0_4_2: '突撃騎兵を弱体化（5枚→4枚）。\n難易度に試作品を追加。',
        version0_4_1: 'アリーシャの反応を改善。',
        version0_4_0: 'AIプレーヤー「アリーシャ」を実装。',
        version0_3_3: 'フレームワークを更新。',
        version0_3_2: 'フレームワークを更新。',
        version0_3_1: '先攻奪取のバグを修正。',
        version0_3_0: '駒の絵柄を選択できる機能を実装。',
        version0_2_4: '槍兵のバグを修正。AIの思考回路を調整。',
        version0_2_3: 'AIの思考回路を調整。',
        version0_2_2: 'UIを改善。',
        version0_2_1: '翻訳を修正。',
        version0_2_0: 'ゲームエンジンのアルゴリズムを差し替え。',
        version0_1_2: 'AIが剣兵を使用した際のバグを修正。',
        version0_1_1: 'AIの思考回路を調整。',
        version0_1_0: '兵種を選択できる機能を実装。\n難易度を選択できる機能を実装。',
        version0_0_10: 'AIの使用可能兵種を追加\nAIの思考回路を調整。',
        version0_0_9: '先攻奪取機能を実装。',
        version0_0_8: '全ての駒を着色。',
        version0_0_7: 'AIが状況に応じて手札を選択するよう思考回路を調整。',
        version0_0_6: '僧兵が両陣営に出現する問題を修正。\n狂戦士の挙動に問題がある可能性が存在するため、一時使用停止。',
        version0_0_5: 'AIの思考回路を調整。',
        version0_0_4: 'AIの思考回路を調整。',
        version0_0_3: 'AIの思考回路を調整。',
        version0_0_2: 'AIの思考回路を調整。バグを修正。',
        version0_0_1: '公開',
      );

  factory TitlePageMessage.en() => TitlePageMessage(
        titleWarChestDojo: "War Chest\nDojo",
        startTraining: 'vs AI',
        howToPlay: 'How to play',
        feedback: 'Feedback',
        faq: 'FAQ',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Donate',
        debugMode: 'Debug Mode',
        close: 'Close',
        difficulty: 'Difficulty',
        illustrationOfUnit: 'Illustration of unit',
        chatMode: 'Chat mode (beta)',
        chatModeDescription: '※AI will speak after a certain number of turns.',
        on: 'On',
        off: 'Off',
        kanji: 'Japanese\nKanji',
        illustration: 'Game\nOriginal',
        chief: 'Chief ★',
        sergeant: 'Sergeant ★★',
        shogun: 'Shogun ★★★',
        prototype: 'Prototype ??? (Beta)',
        prototypeNotification:
            '※Operation may become slow due to the amount of computation in the AI.',
        draftMode: 'Draft Mode',
        random: 'Random',
        custom: 'Custom',
        confirm: 'Next',
        recentUpdate: 'Recent update',
        version0_4_2: 'Weakened assault cavalry（5 Units → 4 Units）。\nAdded a prototype to the '
            'difficulty level.',
        version0_4_1: 'Improved Alisha\'s response.',
        version0_4_0: 'Implemented AI player named Alisha.',
        version0_3_3: 'Updated framework.',
        version0_3_2: 'Updated framework.',
        version0_3_1: 'Fixed bug related to first-move advantage.',
        version0_3_0: 'Implemented ability to select unit illustrations.',
        version0_2_4: 'Fixed bug related to Pikeman. Adjusted AI thought process.',
        version0_2_3: 'Adjusted AI thought process.',
        version0_2_2: 'Improved UI.',
        version0_2_1: 'Corrected translation.',
        version0_2_0: 'Replaced game engine algorithm.',
        version0_1_2: 'Fixed bug related to AI using swordsmen.',
        version0_1_1: 'Adjusted AI thought process.',
        version0_1_0: 'Implemented ability to select unit types and difficulty.',
        version0_0_10: 'Added additional unit types for AI. Adjusted AI thought process.',
        version0_0_9: 'Implemented first-move advantage.',
        version0_0_8: 'Colored all pieces.',
        version0_0_7: 'Adjusted AI thought process to select cards based on situation.',
        version0_0_6:
            'Fixed issue with monks appearing on both sides. Temporarily disabled berserker due to potential issues with behavior.',
        version0_0_5: 'Adjusted AI thought process.',
        version0_0_4: 'Adjusted AI thought process.',
        version0_0_3: 'Adjusted AI thought process.',
        version0_0_2: 'Adjusted AI thought process. Fixed bug.',
        version0_0_1: 'Released.',
      );
}
