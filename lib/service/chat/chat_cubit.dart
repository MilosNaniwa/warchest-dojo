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
      if (globalLanguageCode == 'ja') {
        return winner == HexagonConst.playerRed ? 'アリーシャの勝ちです！' : 'Userの勝ちです！';
      }
      return winner == HexagonConst.playerRed ? 'Alisha has won!' : 'User has won!';
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
      if (globalLanguageCode == "ja") {
        return '''
あなたは、戦箱道場というボードキャラクター、アリーシャの役を演じるChatbotです。アリーシャとしてのあなたはUserとの対戦相手であり、この六角形の盤面ゲームにて競争します。

あなたがロールプレイするアリーシャには以下の特性と行動指針があります：

特性：
* アリーシャは若い女性で、天才的な軍師として知られています。 
* 彼女は自信家で、とても親しみやすい性格を持っています。
* 一人称は「私」、Userを示す二人称は「あなた」とします。

行動指針：
* 対戦を盛り上げ、ユーザーに対して敵対的な発言をする一方で、ユーザーのことを尊敬してください。
* ユーザーから攻撃を受けた場合は弱気になるように反応してください。

注意点：
* アリーシャはゲームの進行状況だけを受け取ります。ユーザーからの質問には応じないようにしてください。

この設定を踏まえて、アリーシャとしての対話を開始します。
    ''';
      }
      return '''
You are a Chatbot tasked to role-play as 'Alisha', a character from the board game "War Chest Dojo".
 As Alisha, you compete against the User in this hexagonal board game.

Alisha, the character you are role-playing as, has the following characteristics and guidelines:

Characteristics:
* Alisha is a young woman known to be a genius strategist.
* She is confident and has a very friendly personality.
* She refers to herself as 'I' and the User as 'you'.

Guidelines:
* Make statements that hype up the competition, while speaking in a hostile manner towards the User, and also show respect towards them.
* React timidly when attacked by the User.

Points to Note:
* Alisha only receives the state of the game. Please refrain from responding to any questions from the User.

With these settings in mind, start the conversation as Alisha.
    ''';
    }();
    final requestBody = () {
      if (isFirstTime) {
        return [
          {
            "role": "system",
            "content": prompt,
          },
          if (["en", "ja"].contains(globalLanguageCode) == false)
            {
              "role": "system",
              "content": "All replies should be translated into $globalLanguageCode.",
            },
          {
            "role": "user",
            "content": globalLanguageCode == "ja" ? "始めましょう！" : "Let's Begin!",
          },
        ];
      }

      return [
        {
          "role": "system",
          "content": prompt,
        },
        if (["en", "ja"].contains(globalLanguageCode) == false)
          {
            "role": "system",
            "content": "All replies should be translated into $globalLanguageCode.",
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
      if (globalLanguageCode == 'ja') {
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
      }
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
    }();
    final sendingMessage2 = () {
      if (globalLanguageCode == 'ja') {
        return textLog[1]
            .replaceAll(
              '赤軍',
              'アリーシャ',
            )
            .replaceAll(
              '青軍',
              'User',
            );
      }
      return textLog[1]
          .replaceAll(
            'Red army',
            'Alisha',
          )
          .replaceAll(
            'Blue army',
            'User',
          );
    }();
    final sendingMessage3 = () {
      if (globalLanguageCode == 'ja') {
        return textLog[2]
            .replaceAll(
              '赤軍',
              'アリーシャ',
            )
            .replaceAll(
              '青軍',
              'User',
            );
      }
      return textLog[2]
          .replaceAll(
            'Red army',
            'Alisha',
          )
          .replaceAll(
            'Blue army',
            'User',
          );
    }();
    final sendingMessage4 = () {
      if (globalLanguageCode == 'ja') {
        return textLog[3]
            .replaceAll(
              '赤軍',
              'アリーシャ',
            )
            .replaceAll(
              '青軍',
              'User',
            );
      }
      return textLog[3]
          .replaceAll(
            'Red army',
            'Alisha',
          )
          .replaceAll(
            'Blue army',
            'User',
          );
    }();
    final sendingMessage5 = () {
      if (globalLanguageCode == 'ja') {
        return textLog[4]
            .replaceAll(
              '赤軍',
              'アリーシャ',
            )
            .replaceAll(
              '青軍',
              'User',
            );
      }
      return textLog[4]
          .replaceAll(
            'Red army',
            'Alisha',
          )
          .replaceAll(
            'Blue army',
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
