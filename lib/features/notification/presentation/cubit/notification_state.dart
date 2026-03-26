import 'package:equatable/equatable.dart';

import '../../domain/entities/app_notification.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.isLoading,
    required this.items,
    required this.error,
  });

  factory NotificationState.initial() =>
      const NotificationState(isLoading: false, items: [], error: '');

  final bool isLoading;
  final List<AppNotification> items;
  final String error;

  NotificationState copyWith({
    bool? isLoading,
    List<AppNotification>? items,
    String? error,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, error];
}
