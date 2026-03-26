import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/inbox_thread.dart';

class InboxState extends Equatable {
  const InboxState({
    required this.isLoading,
    required this.threads,
    required this.messages,
    required this.error,
  });

  factory InboxState.initial() => const InboxState(
        isLoading: false,
        threads: [],
        messages: [],
        error: '',
      );

  final bool isLoading;
  final List<InboxThread> threads;
  final List<ChatMessage> messages;
  final String error;

  InboxState copyWith({
    bool? isLoading,
    List<InboxThread>? threads,
    List<ChatMessage>? messages,
    String? error,
  }) {
    return InboxState(
      isLoading: isLoading ?? this.isLoading,
      threads: threads ?? this.threads,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, threads, messages, error];
}
