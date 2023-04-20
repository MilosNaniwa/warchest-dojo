import 'package:equatable/equatable.dart';

enum ChatStatus {
  initial('初期'),
  inProgress('処理中'),
  success('取得成功'),
  ;

  const ChatStatus(this.message);
  final String message;
}

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.chatBotMessage = '',
  });

  final ChatStatus status;
  final String chatBotMessage;

  ChatState copyWith({
    ChatStatus? status,
    String? chatBotMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      chatBotMessage: chatBotMessage ?? this.chatBotMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        chatBotMessage,
      ];

  @override
  String toString() => status.message;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status.toString(),
        'chatBotMessage': chatBotMessage,
      };
}
