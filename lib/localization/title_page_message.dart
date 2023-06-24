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
  });

  factory TitlePageMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return TitlePageMessage.ja();
      case 'en':
        return TitlePageMessage.en();
      case 'zh':
        return TitlePageMessage.zh();
      case 'ko':
        return TitlePageMessage.ko();
      case 'ru':
        return TitlePageMessage.ru();
      case 'uk':
        return TitlePageMessage.uk();
      case 'hr':
        return TitlePageMessage.hr();
      case 'fr':
        return TitlePageMessage.fr();
      case 'it':
        return TitlePageMessage.it();
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
      );

  factory TitlePageMessage.zh() => TitlePageMessage(
        titleWarChestDojo: "戰爭寶箱\n道場",
        startTraining: '對 AI',
        howToPlay: '如何遊玩',
        feedback: '反饋',
        faq: '常見問題',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: '捐贈',
        debugMode: '調試模式',
        close: '關閉',
        difficulty: '難度',
        illustrationOfUnit: '單位插圖',
        chatMode: '聊天模式 (測試中)',
        chatModeDescription: '※AI 將在一定數量的回合後說話。',
        on: '開',
        off: '關',
        kanji: '日文\n漢字',
        illustration: '遊戲\n原創',
        chief: '首領 ★',
        sergeant: '中士 ★★',
        shogun: '將軍 ★★★',
        prototype: '原型 ??? (測試中)',
        prototypeNotification: '※由於 AI 的計算量，操作可能會變慢。',
        draftMode: '草稿模式',
        random: '隨機',
        custom: '自定義',
        confirm: '下一步',
        recentUpdate: '最近更新',
      );

  factory TitlePageMessage.ko() => TitlePageMessage(
        titleWarChestDojo: "전쟁 상자\n도장",
        startTraining: 'vs AI',
        howToPlay: '게임 방법',
        feedback: '피드백',
        faq: 'FAQ',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: '기부',
        debugMode: '디버그 모드',
        close: '닫기',
        difficulty: '난이도',
        illustrationOfUnit: '유닛의 일러스트레이션',
        chatMode: '채팅 모드 (베타)',
        chatModeDescription: '※AI는 일정 턴 후에 대화합니다.',
        on: '켜기',
        off: '끄기',
        kanji: '일본어\n한자',
        illustration: '게임\n원작',
        chief: '족장 ★',
        sergeant: '중사 ★★',
        shogun: '장군 ★★★',
        prototype: '프로토타입 ??? (베타)',
        prototypeNotification: '※AI의 계산량으로 인해 운영이 느려질 수 있습니다.',
        draftMode: '드래프트 모드',
        random: '랜덤',
        custom: '사용자 정의',
        confirm: '다음',
        recentUpdate: '최신 업데이트',
      );

  factory TitlePageMessage.ru() => TitlePageMessage(
        titleWarChestDojo: "Военная казна\nДодзё",
        startTraining: 'против AI',
        howToPlay: 'Как играть',
        feedback: 'Отзывы',
        faq: 'FAQ',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Пожертвовать',
        debugMode: 'Режим отладки',
        close: 'Закрыть',
        difficulty: 'Сложность',
        illustrationOfUnit: 'Иллюстрация юнита',
        chatMode: 'Чат (бета)',
        chatModeDescription: '※AI будет говорить после определенного числа ходов.',
        on: 'Вкл',
        off: 'Выкл',
        kanji: 'Японские\nКандзи',
        illustration: 'Игровая\nОригинал',
        chief: 'Вождь ★',
        sergeant: 'Сержант ★★',
        shogun: 'Сёгун ★★★',
        prototype: 'Прототип ??? (Бета)',
        prototypeNotification: '※Операция может замедлиться из-за количества вычислений в AI.',
        draftMode: 'Режим черновика',
        random: 'Случайный',
        custom: 'Пользовательский',
        confirm: 'Далее',
        recentUpdate: 'Последнее обновление',
      );

  factory TitlePageMessage.uk() => TitlePageMessage(
        titleWarChestDojo: "Військова Скриня\nДодзьо",
        startTraining: 'проти AI',
        howToPlay: 'Як грати',
        feedback: 'Зворотний зв’язок',
        faq: 'Часті питання',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Пожертвувати',
        debugMode: 'Режим налагодження',
        close: 'Закрити',
        difficulty: 'Складність',
        illustrationOfUnit: 'Ілюстрація одиниці',
        chatMode: 'Режим чату (бета)',
        chatModeDescription: '※AI буде говорити після певної кількості ходів.',
        on: 'Увімк.',
        off: 'Вимк.',
        kanji: 'Японські\nКандзі',
        illustration: 'Гра\nОригінал',
        chief: 'Вождь ★',
        sergeant: 'Сержант ★★',
        shogun: 'Сьогун ★★★',
        prototype: 'Прототип ??? (Бета)',
        prototypeNotification: '※Операція може стати повільною через кількість обчислень в AI.',
        draftMode: 'Режим чернетки',
        random: 'Випадковий',
        custom: 'Користувацький',
        confirm: 'Далі',
        recentUpdate: 'Останнє оновлення',
      );

  factory TitlePageMessage.hr() => TitlePageMessage(
        titleWarChestDojo: "Ratna prsa\nDojo",
        startTraining: 'protiv AI',
        howToPlay: 'Kako igrati',
        feedback: 'Povratne informacije',
        faq: 'Često postavljena pitanja',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Doniraj',
        debugMode: 'Način za otklanjanje pogrešaka',
        close: 'Zatvori',
        difficulty: 'Težina',
        illustrationOfUnit: 'Ilustracija jedinice',
        chatMode: 'Način razgovora (beta)',
        chatModeDescription: '※AI će govoriti nakon određenog broja poteza.',
        on: 'Uključeno',
        off: 'Isključeno',
        kanji: 'Japanski\nKanji',
        illustration: 'Igra\nOriginal',
        chief: 'Šef ★',
        sergeant: 'Narednik ★★',
        shogun: 'Šogun ★★★',
        prototype: 'Prototip ??? (Beta)',
        prototypeNotification: '※Operacija može postati spora zbog količine izračuna u AI.',
        draftMode: 'Način skice',
        random: 'Nasumično',
        custom: 'Prilagođeno',
        confirm: 'Sljedeće',
        recentUpdate: 'Nedavno ažuriranje',
      );

  factory TitlePageMessage.fr() => TitlePageMessage(
        titleWarChestDojo: "Coffre de guerre\nDojo",
        startTraining: 'vs IA',
        howToPlay: 'Comment jouer',
        feedback: 'Retour',
        faq: 'FAQ',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Faire un don',
        debugMode: 'Mode debug',
        close: 'Fermer',
        difficulty: 'Difficulté',
        illustrationOfUnit: 'Illustration de l\'unité',
        chatMode: 'Mode de chat (beta)',
        chatModeDescription: '※L\'IA parlera après un certain nombre de tours.',
        on: 'On',
        off: 'Off',
        kanji: 'Japonais\nKanji',
        illustration: 'Jeu\nOriginal',
        chief: 'Chef ★',
        sergeant: 'Sergent ★★',
        shogun: 'Shogun ★★★',
        prototype: 'Prototype ??? (Beta)',
        prototypeNotification:
            '※L\'opération peut devenir lente en raison de la quantité de calculs dans l\'IA.',
        draftMode: 'Mode brouillon',
        random: 'Aléatoire',
        custom: 'Personnalisé',
        confirm: 'Suivant',
        recentUpdate: 'Mise à jour récente',
      );

  factory TitlePageMessage.it() => TitlePageMessage(
        titleWarChestDojo: "Tesoro di guerra\nDojo",
        startTraining: 'vs IA',
        howToPlay: 'Come giocare',
        feedback: 'Feedback',
        faq: 'FAQ',
        feedbackUrl:
            'https://docs.google.com/forms/d/16U8ZziTQ7Yu_AWQNR1qZGPRXYD9aumGEYmz54IoEmeg/viewform',
        supportCreator: 'Donare',
        debugMode: 'Modalità di debug',
        close: 'Chiudi',
        difficulty: 'Difficoltà',
        illustrationOfUnit: 'Illustrazione dell\'unità',
        chatMode: 'Modalità chat (beta)',
        chatModeDescription: '※L\'IA parlerà dopo un certo numero di turni.',
        on: 'On',
        off: 'Off',
        kanji: 'Giapponese\nKanji',
        illustration: 'Gioco\nOriginale',
        chief: 'Capo ★',
        sergeant: 'Sergente ★★',
        shogun: 'Shogun ★★★',
        prototype: 'Prototipo ??? (Beta)',
        prototypeNotification:
            '※L\'operazione potrebbe diventare lenta a causa della quantità di calcoli nell\'IA.',
        draftMode: 'Modalità bozza',
        random: 'Casuale',
        custom: 'Personalizzato',
        confirm: 'Avanti',
        recentUpdate: 'Aggiornamento recente',
      );
}
