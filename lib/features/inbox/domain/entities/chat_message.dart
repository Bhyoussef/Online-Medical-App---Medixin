import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.type,
    required this.time,
  });

  final String id;
  final String text;
  final bool isMe;
  final String type;
  final String time;

  @override
  List<Object?> get props => [id, text, isMe, type, time];
}
