import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_notifications_usecase.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._getNotificationsUseCase)
      : super(NotificationState.initial());

  final GetNotificationsUseCase _getNotificationsUseCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final items = await _getNotificationsUseCase();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load notifications'));
    }
  }

  void clearAll() {
    emit(state.copyWith(items: []));
  }

  void markAllRead() {
    emit(
      state.copyWith(
        items: state.items.map((e) => e.copyWith(isRead: true)).toList(),
      ),
    );
  }
}
