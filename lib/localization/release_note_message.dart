class ReleaseNoteMessage {
  final String version0_5_0;
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

  ReleaseNoteMessage({
    required this.version0_5_0,
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

  factory ReleaseNoteMessage.of(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return ReleaseNoteMessage.ja();
      case 'en':
        return ReleaseNoteMessage.en();
      case 'zh':
        return ReleaseNoteMessage.zh();
      case 'ko':
        return ReleaseNoteMessage.ko();
      case 'ru':
        return ReleaseNoteMessage.ru();
      case 'uk':
        return ReleaseNoteMessage.uk();
      case 'hr':
        return ReleaseNoteMessage.hr();
      case 'fr':
        return ReleaseNoteMessage.fr();
      case 'it':
        return ReleaseNoteMessage.it();
      default:
        return ReleaseNoteMessage.en();
    }
  }

  factory ReleaseNoteMessage.ja() => ReleaseNoteMessage(
        version0_5_0: '次の翻訳を追加。\n中国語/韓国語/フランス語/イタリア語/クロアチア語',
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

  factory ReleaseNoteMessage.en() => ReleaseNoteMessage(
        version0_5_0: 'Added the following translations.\nChinese/Korean/French/Italian/Croatian',
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

  factory ReleaseNoteMessage.zh() => ReleaseNoteMessage(
        version0_5_0: '新增以下翻譯。\n中文/韓文/法文/義大利文/克羅埃西亞文',
        version0_4_2: '弱化突擊騎兵（5個單位 → 4個單位）。\n增加了難度等級的原型。',
        version0_4_1: '提高了阿麗莎的回應。',
        version0_4_0: '實施了名為阿麗莎的AI玩家。',
        version0_3_3: '更新了框架。',
        version0_3_2: '更新了框架。',
        version0_3_1: '修正了與先手優勢相關的錯誤。',
        version0_3_0: '實現了選擇單位插圖的能力。',
        version0_2_4: '修正了與長槍兵相關的錯誤。調整了AI的思考過程。',
        version0_2_3: '調整了AI的思考過程。',
        version0_2_2: '改進了UI。',
        version0_2_1: '修正了翻譯。',
        version0_2_0: '更換了遊戲引擎算法。',
        version0_1_2: '修正了與AI使用劍士相關的錯誤。',
        version0_1_1: '調整了AI的思考過程。',
        version0_1_0: '實現了選擇單位類型和難度的能力。',
        version0_0_10: '為AI增加了額外的單位類型。調整了AI的思考過程。',
        version0_0_9: '實現了先手優勢。',
        version0_0_8: '給所有棋子上色。',
        version0_0_7: '根據情況調整AI選擇卡牌的思考過程。',
        version0_0_6: '修正了僧侶出現在雙方的問題。因為可能存在行為問題，暫時禁用了狂戰士。',
        version0_0_5: '調整了AI的思考過程。',
        version0_0_4: '調整了AI的思考過程。',
        version0_0_3: '調整了AI的思考過程。',
        version0_0_2: '調整了AI的思考過程。修正了錯誤。',
        version0_0_1: '發布。',
      );

  factory ReleaseNoteMessage.ko() => ReleaseNoteMessage(
        version0_5_0: '다음 번역 추가.\n중국어/한국어/프랑스어/이탈리아어/크로아티아어',
        version0_4_2: '돌격기병 약화（5개 부대 → 4개 부대）。\n난이도 레벨에 프로토타입을 추가했습니다.',
        version0_4_1: '알리샤의 반응을 개선했습니다.',
        version0_4_0: '알리샤라는 이름의 AI 플레이어를 구현했습니다.',
        version0_3_3: '프레임워크를 업데이트했습니다.',
        version0_3_2: '프레임워크를 업데이트했습니다.',
        version0_3_1: '선수 이점과 관련된 버그를 수정했습니다.',
        version0_3_0: '유닛 그림을 선택할 수 있는 기능을 구현했습니다.',
        version0_2_4: '창병과 관련된 버그를 수정했습니다. AI의 생각 과정을 조정했습니다.',
        version0_2_3: 'AI의 생각 과정을 조정했습니다.',
        version0_2_2: 'UI를 개선했습니다.',
        version0_2_1: '번역을 수정했습니다.',
        version0_2_0: '게임 엔진 알고리즘을 교체했습니다.',
        version0_1_2: 'AI가 검사를 사용하는 것과 관련된 버그를 수정했습니다.',
        version0_1_1: 'AI의 생각 과정을 조정했습니다.',
        version0_1_0: '유닛 유형과 난이도를 선택할 수 있는 기능을 구현했습니다.',
        version0_0_10: 'AI를 위한 추가 유닛 유형을 추가했습니다. AI의 생각 과정을 조정했습니다.',
        version0_0_9: '선수 이점을 구현했습니다.',
        version0_0_8: '모든 말을 색칠했습니다.',
        version0_0_7: '상황에 따라 카드를 선택하는 AI의 생각 과정을 조정했습니다.',
        version0_0_6: '양쪽에 수도사가 나타나는 문제를 수정했습니다. 행동에 문제가 있을 가능성이 있는 버서커를 일시적으로 사용 중지했습니다.',
        version0_0_5: 'AI의 생각 과정을 조정했습니다.',
        version0_0_4: 'AI의 생각 과정을 조정했습니다.',
        version0_0_3: 'AI의 생각 과정을 조정했습니다.',
        version0_0_2: 'AI의 생각 과정을 조정했습니다. 버그를 수정했습니다.',
        version0_0_1: '발표했습니다.',
      );

  factory ReleaseNoteMessage.ru() => ReleaseNoteMessage(
        version0_5_0:
            'Добавлены следующие переводы.\nКитайский/Корейский/Французский/Итальянский/Хорватский',
        version0_4_2:
            'Ослаблена атакующая кавалерия（5 единиц → 4 единицы）。\nДобавлен прототип уровня сложности.',
        version0_4_1: 'Улучшен ответ Алиши.',
        version0_4_0: 'Реализован AI игрок по имени Алиша.',
        version0_3_3: 'Обновлена рамка.',
        version0_3_2: 'Обновлена рамка.',
        version0_3_1: 'Исправлена ошибка, связанная с преимуществом первого хода.',
        version0_3_0: 'Реализована возможность выбора иллюстраций для юнитов.',
        version0_2_4: 'Исправлена ошибка, связанная с пикейщиком. Доработан процесс мышления AI.',
        version0_2_3: 'Доработан процесс мышления AI.',
        version0_2_2: 'Улучшен пользовательский интерфейс.',
        version0_2_1: 'Исправлен перевод.',
        version0_2_0: 'Заменен алгоритм игрового движка.',
        version0_1_2: 'Исправлена ошибка, связанная с использованием AI мечниками.',
        version0_1_1: 'Доработан процесс мышления AI.',
        version0_1_0: 'Реализована возможность выбора типов юнитов и сложности.',
        version0_0_10:
            'Добавлены дополнительные типы юнитов для AI. Доработан процесс мышления AI.',
        version0_0_9: 'Реализовано преимущество первого хода.',
        version0_0_8: 'Окрашены все фигуры.',
        version0_0_7: 'Процесс мышления AI для выбора карт настроен в зависимости от ситуации.',
        version0_0_6:
            'Исправлена проблема с появлением монахов на обеих сторонах. Временно отключен берсерк из-за возможных проблем с поведением.',
        version0_0_5: 'Доработан процесс мышления AI.',
        version0_0_4: 'Доработан процесс мышления AI.',
        version0_0_3: 'Доработан процесс мышления AI.',
        version0_0_2: 'Доработан процесс мышления AI. Исправлена ошибка.',
        version0_0_1: 'Выпущено.',
      );

  factory ReleaseNoteMessage.uk() => ReleaseNoteMessage(
        version0_5_0:
            'Додано наступні переклади.\nКитайська/Корейська/Французька/Італійська/Хорватська',
        version0_4_2:
            'Ослаблено штурмову кавалерію（5 одиниць → 4 одиниці）.\nДодано прототип до рівня складності.',
        version0_4_1: 'Покращено відповідь Аліши.',
        version0_4_0: 'Реалізовано AI гравець під назвою Аліша.',
        version0_3_3: 'Оновлено фреймворк.',
        version0_3_2: 'Оновлено фреймворк.',
        version0_3_1: 'Виправлено помилку, по\'язану з перевагою першого ходу.',
        version0_3_0: 'Впроваджено можливість вибору ілюстрацій юнітів.',
        version0_2_4:
            'Виправлена помилка, пов\'язана з пікінером. Підлаштовано процес мислення AI.',
        version0_2_3: 'Підлаштовано процес мислення AI.',
        version0_2_2: 'Покращено UI.',
        version0_2_1: 'Виправлено переклад.',
        version0_2_0: 'Замінено алгоритм грального двигуна.',
        version0_1_2: 'Виправлена помилка, пов\'язана з використанням AI мечниками.',
        version0_1_1: 'Підлаштовано процес мислення AI.',
        version0_1_0: 'Впроваджено можливість вибору типів юнітів та складності.',
        version0_0_10: 'Додано додаткові типи юнітів для AI. Підлаштовано процес мислення AI.',
        version0_0_9: 'Впроваджено перевагу першого ходу.',
        version0_0_8: 'Забарвлено всі фігури.',
        version0_0_7: 'Настроєно процес мислення AI для вибору карток в залежності від ситуації.',
        version0_0_6:
            'Виправлена проблема з появою монахів на обох боках. Тимчасово вимкнено берсеркера через потенційні проблеми з поведінкою.',
        version0_0_5: 'Підлаштовано процес мислення AI.',
        version0_0_4: 'Підлаштовано процес мислення AI.',
        version0_0_3: 'Підлаштовано процес мислення AI.',
        version0_0_2: 'Підлаштовано процес мислення AI. Виправлена помилка.',
        version0_0_1: 'Випущено.',
      );

  factory ReleaseNoteMessage.hr() => ReleaseNoteMessage(
        version0_5_0:
            'Dodane su sljedeće prevodi.\nKineski/Korejski/Francuski/Italijanski/Hrvatski',
        version0_4_2:
            'Oslobođena jahačka kavalerija（5 jedinica → 4 jedinice）.\nDodan je prototip za razinu težine.',
        version0_4_1: 'Poboljšan Alishin odgovor.',
        version0_4_0: 'Implementiran AI igrač imenom Alisha.',
        version0_3_3: 'Ažuriran okvir.',
        version0_3_2: 'Ažuriran okvir.',
        version0_3_1: 'Ispravljen je bug povezan s prednošću prvog poteza.',
        version0_3_0: 'Implementirana mogućnost odabira ilustracija jedinica.',
        version0_2_4:
            'Ispravljen je bug povezan s Pikemanom. Podešen je proces razmišljanja AI-ja.',
        version0_2_3: 'Podešen je proces razmišljanja AI-ja.',
        version0_2_2: 'Poboljšano korisničko sučelje.',
        version0_2_1: 'Ispravljena je prijevod.',
        version0_2_0: 'Zamijenjen je algoritam igre.',
        version0_1_2: 'Ispravljen je bug povezan s AI koji koristi mačevaoce.',
        version0_1_1: 'Podešen je proces razmišljanja AI-ja.',
        version0_1_0: 'Implementirana je mogućnost odabira tipova jedinica i težine.',
        version0_0_10:
            'Dodane su dodatne vrste jedinica za AI. Podešen je proces razmišljanja AI-ja.',
        version0_0_9: 'Implementirana je prednost prvog poteza.',
        version0_0_8: 'Obojano su sve figure.',
        version0_0_7: 'Podešen je proces razmišljanja AI-ja za odabir karti na temelju situacije.',
        version0_0_6:
            'Ispravljena je pogreška s pojavljivanjem redovnika na obje strane. Privremeno je onemogućen Berserker zbog potencijalnih problema s ponašanjem.',
        version0_0_5: 'Podešen je proces razmišljanja AI-ja.',
        version0_0_4: 'Podešen je proces razmišljanja AI-ja.',
        version0_0_3: 'Podešen je proces razmišljanja AI-ja.',
        version0_0_2: 'Podešen je proces razmišljanja AI-ja. Popravljen je bug.',
        version0_0_1: 'Objavljeno.',
      );

  factory ReleaseNoteMessage.fr() => ReleaseNoteMessage(
        version0_5_0: 'Ajout des traductions suivantes.\nChinois/Coréen/Français/Italien/Croate',
        version0_4_2:
            'Affaiblissement de la cavalerie d\'assaut（5 unités → 4 unités）.\nAjout d\'un prototype au niveau de difficulté.',
        version0_4_1: 'Amélioration de la réponse d\'Alisha.',
        version0_4_0: 'Mise en œuvre d\'un joueur IA nommé Alisha.',
        version0_3_3: 'Mise à jour du cadre.',
        version0_3_2: 'Mise à jour du cadre.',
        version0_3_1: 'Correction d\'un bug lié à l\'avantage du premier mouvement.',
        version0_3_0:
            'Mise en œuvre de la possibilité de sélectionner des illustrations d\'unités.',
        version0_2_4:
            'Correction d\'un bug lié au Pikeman. Ajustement du processus de réflexion de l\'IA.',
        version0_2_3: 'Ajustement du processus de réflexion de l\'IA.',
        version0_2_2: 'Amélioration de l\'interface utilisateur.',
        version0_2_1: 'Correction de la traduction.',
        version0_2_0: 'Remplacement de l\'algorithme du moteur de jeu.',
        version0_1_2: 'Correction d\'un bug lié à l\'utilisation de l\'IA avec les épéistes.',
        version0_1_1: 'Ajustement du processus de réflexion de l\'IA.',
        version0_1_0:
            'Mise en œuvre de la possibilité de sélectionner des types d\'unités et la difficulté.',
        version0_0_10:
            'Ajout de types d\'unités supplémentaires pour l\'IA. Ajustement du processus de réflexion de l\'IA.',
        version0_0_9: 'Mise en œuvre de l\'avantage du premier mouvement.',
        version0_0_8: 'Coloration de toutes les pièces.',
        version0_0_7:
            'Ajustement du processus de réflexion de l\'IA pour sélectionner des cartes en fonction de la situation.',
        version0_0_6:
            'Correction du problème avec les moines apparaissant des deux côtés. Désactivation temporaire du berserker en raison de problèmes potentiels de comportement.',
        version0_0_5: 'Ajustement du processus de réflexion de l\'IA.',
        version0_0_4: 'Ajustement du processus de réflexion de l\'IA.',
        version0_0_3: 'Ajustement du processus de réflexion de l\'IA.',
        version0_0_2: 'Ajustement du processus de réflexion de l\'IA. Correction d\'un bug.',
        version0_0_1: 'Publié.',
      );

  factory ReleaseNoteMessage.it() => ReleaseNoteMessage(
        version0_5_0: 'Aggiunte le seguenti traduzioni.\nCinese/Coreano/Francese/Italiano/Croato',
        version0_4_2:
            'Abbiamo indebolito la cavalleria d\'assalto（5 unità → 4 unità）.\nAggiunto un prototipo al livello di difficoltà.',
        version0_4_1: 'Migliorata la risposta di Alisha.',
        version0_4_0: 'Implementato un giocatore AI chiamato Alisha.',
        version0_3_3: 'Aggiornato il framework.',
        version0_3_2: 'Aggiornato il framework.',
        version0_3_1: 'Corretto un bug legato al vantaggio del primo movimento.',
        version0_3_0: 'Implementata la possibilità di selezionare illustrazioni delle unità.',
        version0_2_4:
            'Corretto un bug relativo al Pikeman. Ajustato il processo di pensiero dell\'IA.',
        version0_2_3: 'Ajustato il processo di pensiero dell\'IA.',
        version0_2_2: 'Migliorata l\'interfaccia utente.',
        version0_2_1: 'Corretta la traduzione.',
        version0_2_0: 'Sostituito l\'algoritmo del motore di gioco.',
        version0_1_2: 'Corretto un bug legato all\'uso dell\'IA con gli spadaccini.',
        version0_1_1: 'Ajustato il processo di pensiero dell\'IA.',
        version0_1_0: 'Implementata la possibilità di selezionare tipi di unità e difficoltà.',
        version0_0_10:
            'Aggiunti ulteriori tipi di unità per l\'IA. Ajustato il processo di pensiero dell\'IA.',
        version0_0_9: 'Implementato il vantaggio del primo movimento.',
        version0_0_8: 'Colorate tutte le pedine.',
        version0_0_7:
            'Ajustato il processo di pensiero dell\'IA per selezionare le carte in base alla situazione.',
        version0_0_6:
            'Risolto il problema con i monaci che appaiono su entrambi i lati. Disabilitato temporaneamente il berserker a causa di potenziali problemi con il comportamento.',
        version0_0_5: 'Ajustato il processo di pensiero dell\'IA.',
        version0_0_4: 'Ajustato il processo di pensiero dell\'IA.',
        version0_0_3: 'Ajustato il processo di pensiero dell\'IA.',
        version0_0_2: 'Ajustato il processo di pensiero dell\'IA. Corretto un bug.',
        version0_0_1: 'Rilasciato.',
      );
}
