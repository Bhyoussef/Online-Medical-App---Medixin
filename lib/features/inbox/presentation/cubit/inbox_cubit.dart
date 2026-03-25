import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/get_threads_usecase.dart';
import 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit(this._getThreadsUseCase, this._getMessagesUseCase)
      : super(InboxState.initial());

  final GetThreadsUseCase _getThreadsUseCase;
  final GetMessagesUseCase _getMessagesUseCase;

  Future<void> loadThreads() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final threads = await _getThreadsUseCase();
      emit(state.copyWith(isLoading: false, threads: threads));
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load inbox'));
    }
  }

  Future<void> loadMessages(String threadId) async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final messages = await _getMessagesUseCase(threadId);
      emit(state.copyWith(isLoading: false, messages: messages));
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load messages'));
    }
  }
}
