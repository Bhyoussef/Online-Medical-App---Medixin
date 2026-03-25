import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.text,
    required super.isMe,
    required super.type,
    required super.time,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) => ChatMessageModel(
        id: map['id'] as String,
        text: map['text'] as String,
        isMe: map['isMe'] as bool,
        type: map['type'] as String,
        time: map['time'] as String,
      );
}
