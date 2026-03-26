import 'package:equatable/equatable.dart';

class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.message,
    required this.type,
    required this.isToday,
    required this.isRead,
  });

  final String id;
  final String message;
  final String type;
  final bool isToday;
  final bool isRead;

  AppNotification copyWith({
    String? id,
    String? message,
    String? type,
    bool? isToday,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      isToday: isToday ?? this.isToday,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, message, type, isToday, isRead];
}
