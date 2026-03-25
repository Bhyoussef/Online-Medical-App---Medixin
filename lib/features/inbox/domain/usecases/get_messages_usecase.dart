import '../entities/chat_message.dart';
import '../repositories/inbox_repository.dart';

class GetMessagesUseCase {
  const GetMessagesUseCase(this._repository);

  final InboxRepository _repository;

  Future<List<ChatMessage>> call(String threadId) => _repository.getMessages(threadId);
}
