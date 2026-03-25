import '../entities/chat_message.dart';
import '../entities/inbox_thread.dart';

abstract interface class InboxRepository {
  Future<List<InboxThread>> getThreads();
  Future<List<ChatMessage>> getMessages(String threadId);
}
