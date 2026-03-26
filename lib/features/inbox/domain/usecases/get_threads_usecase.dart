import '../entities/inbox_thread.dart';
import '../repositories/inbox_repository.dart';

class GetThreadsUseCase {
  const GetThreadsUseCase(this._repository);

  final InboxRepository _repository;

  Future<List<InboxThread>> call() => _repository.getThreads();
}
