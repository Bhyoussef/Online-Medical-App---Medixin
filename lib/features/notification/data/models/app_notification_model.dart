import '../../domain/entities/app_notification.dart';

class AppNotificationModel extends AppNotification {
  const AppNotificationModel({
    required super.id,
    required super.message,
    required super.type,
    required super.isToday,
    required super.isRead,
  });

  factory AppNotificationModel.fromMap(Map<String, dynamic> map) =>
      AppNotificationModel(
        id: map['id'] as String,
        message: map['message'] as String,
        type: map['type'] as String,
        isToday: map['isToday'] as bool,
        isRead: map['isRead'] as bool,
      );
}
