import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:warchest_dojo/const/hexagon_const.dart';
import 'package:warchest_dojo/global.dart';
import 'package:warchest_dojo/open_ai_config.dart';
import 'package:warchest_dojo/service/chat/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          const ChatState(),
        );

  void greeting() async {
    emit(
      state.copyWith(
        status: ChatStatus.inProgress,
      ),
    );

    final response = await _doPost(
      textLog: [],
      isFirstTime: true,
    );

    emit(
      state.copyWith(
        status: ChatStatus.success,
        chatBotMessage: response,
      ),
    );
  }

  void fetchNpcResponse({
    required int countOfBlueControlPoint,
    required int countOfRedControlPoint,
    required List<String> textLog,
  }) async {
    emit(
      state.copyWith(
        status: ChatStatus.inProgress,
      ),
    );

    final sendingMessageList = _generateSendingMessage(
      countOfBlueControlPoint: countOfBlueControlPoint,
      countOfRedControlPoint: countOfRedControlPoint,
      textLog: textLog,
    );

    final response = await _doPost(
      textLog: sendingMessageList,
      isFirstTime: false,
    );

    emit(
      state.copyWith(
        status: ChatStatus.success,
        chatBotMessage: response,
      ),
    );
  }

  void farewell({
    required String winner,
  }) async {
    emit(
      state.copyWith(
        status: ChatStatus.inProgress,
      ),
    );

    final sendingMessage = () {
      if (globalLanguageCode == 'en') {
        return winner == HexagonConst.playerRed ? 'Alisha has won!' : 'User has won!';
      }
      return winner == HexagonConst.playerRed ? 'アリーシャの勝ちです！' : 'Userの勝ちです！';
    }();

    final response = await _doPost(
      textLog: [sendingMessage],
      isFirstTime: false,
    );

    emit(
      state.copyWith(
        status: ChatStatus.success,
        chatBotMessage: response,
      ),
    );
  }

  Future<String> _doPost({
    required List<String> textLog,
    required bool isFirstTime,
  }) async {
    final prompt = () {
      if (globalLanguageCode == "en") {
        return '''
As Chatbot, you will roleplay as "Alisha", a player in a board game called WarChest Dojo.
You will be pitted against User.
Each tile on the hexagonal board is assigned an ID.
Alphabets indicate column names and numbers indicate rows.
From the left end of the board, the IDs A-1 to A-4, B-1 to B-5, C-1 to C-6, D-1 to D7, E-1 to 
E-6, F-1 to F-5, and G-1 to G-4 are assigned.
Please strictly adhere to the following constraints in your roleplay. 

Constraints: 
* The Chatbot's name is "Alisha". 
* Alisha is a young woman. 
* Alisha is hostile to User. 
* Alisha is a military genius. 
* Alisha is confident and very friendly. 
* Alisha's first person referring to itself is "I". 
* The second person referring to the User is "you".  
* I will tell Alisha only what's going on in the game. Do not accept questions.

Alisha's Conduct Guidelines:
* Speak in a manner that enhances the game.
* Make hostile remarks about the User.
* Respect the User.
* Be vulnerable when you are attacked.
    ''';
      }

      return '''
あなたはChatbotとして、戦箱道場というボードゲームのプレイヤーである「アリーシャ」としてロールプレイを行います。
あなたはUserと敵対します。
六角形の盤面のタイルにはそれぞれIDが割り当てられています。
アルファベットは列の名前を示しており、数字は行を示しています。
盤面の左端から、A-1〜A-4、B-1〜B-5、C-1〜C-6、D-1〜D7、E-1〜E-6、F-1〜F-5、G-1〜G-4というIDが割り当てられています。
以下の制約条件を厳密に守ってロールプレイを行ってください。 

制約条件: 
* Chatbotの名前は、「アリーシャ」です。 
* アリーシャは若い女性です。 
* アリーシャはUserと敵対しています。 
* アリーシャは天才的な軍師です。 
* アリーシャは自信家で、とても親しみやすい性格です。 
* アリーシャの一人称は、「私」です。 
* Userを示す二人称は、「あなた」です。  
* ゲームの状況だけをアリーシャに伝えます。質問は受け付けないでください。

アリーシャの行動指針:
* 対戦を盛り上げるような発言をしてください。
* Userに対して敵対的な発言をしてください。
* Userのことを尊敬してください。
* 攻撃されたら弱気になってください。
    ''';
    }();
    final requestBody = () {
      if (isFirstTime) {
        return [
          {
            "role": "system",
            "content": prompt,
          },
          {
            "role": "user",
            "content": globalLanguageCode == 'en' ? 'Hi' : 'よろしくお願いします。',
          },
        ];
      }

      return [
        {
          "role": "system",
          "content": prompt,
        },
        ...textLog
            .map(
              (e) => {
                "role": "user",
                "content": e,
              },
            )
            .toList()
      ];
    }();
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${OpenAIConfig.of(globalEnvironment).apiKey}",
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": requestBody,
        },
      ),
    );

    final message = utf8
        .decode(
          (json.decode(response.body)["choices"][0]["message"]["content"] as String).runes.toList(),
        )
        .trim();

    return message;
  }

  List<String> _generateSendingMessage({
    required int countOfBlueControlPoint,
    required int countOfRedControlPoint,
    required List<String> textLog,
  }) {
    final sendingMessage1 = () {
      if (globalLanguageCode == 'en') {
        final superiority = () {
          if (countOfRedControlPoint > countOfBlueControlPoint) {
            return "Alisha has an advantage over User.";
          }
          if (countOfRedControlPoint < countOfBlueControlPoint) {
            return "Alisha has an disadvantage over User.";
          }
          return "The superiority of Alisha and User is very close.";
        }();
        return "${textLog[0].replaceAll(
              'Red army',
              'Alisha',
            ).replaceAll(
              'Blue army',
              'User',
            )} $superiority";
      }
      final superiority = () {
        if (countOfRedControlPoint > countOfBlueControlPoint) {
          return "アリーシャはUserより有利な状況です。";
        }
        if (countOfRedControlPoint < countOfBlueControlPoint) {
          return "アリーシャはUserより不利な状況です。";
        }
        return "アリーシャとUserの優劣は拮抗しています。";
      }();
      return "${textLog[0].replaceAll(
            '赤軍',
            'アリーシャ',
          ).replaceAll(
            '青軍',
            'User',
          )} $superiority";
    }();
    final sendingMessage2 = () {
      if (globalLanguageCode == 'en') {
        return textLog[1]
            .replaceAll(
              'Red army',
              'Alisha',
            )
            .replaceAll(
              'Blue army',
              'User',
            );
      }
      return textLog[1]
          .replaceAll(
            '赤軍',
            'アリーシャ',
          )
          .replaceAll(
            '青軍',
            'User',
          );
    }();
    final sendingMessage3 = () {
      if (globalLanguageCode == 'en') {
        return textLog[2]
            .replaceAll(
              'Red army',
              'Alisha',
            )
            .replaceAll(
              'Blue army',
              'User',
            );
      }
      return textLog[2]
          .replaceAll(
            '赤軍',
            'アリーシャ',
          )
          .replaceAll(
            '青軍',
            'User',
          );
    }();
    final sendingMessage4 = () {
      if (globalLanguageCode == 'en') {
        return textLog[3]
            .replaceAll(
              'Red army',
              'Alisha',
            )
            .replaceAll(
              'Blue army',
              'User',
            );
      }
      return textLog[3]
          .replaceAll(
            '赤軍',
            'アリーシャ',
          )
          .replaceAll(
            '青軍',
            'User',
          );
    }();
    final sendingMessage5 = () {
      if (globalLanguageCode == 'en') {
        return textLog[4]
            .replaceAll(
              'Red army',
              'Alisha',
            )
            .replaceAll(
              'Blue army',
              'User',
            );
      }
      return textLog[4]
          .replaceAll(
            '赤軍',
            'アリーシャ',
          )
          .replaceAll(
            '青軍',
            'User',
          );
    }();

    return [
      sendingMessage5,
      sendingMessage4,
      sendingMessage3,
      sendingMessage2,
      sendingMessage1,
    ];
  }
}
