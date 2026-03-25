import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/app_notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<List<AppNotification>> getNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    const rows = [
      {
        'id': 'n1',
        'message': 'Hey Rafi, your password was successfully reseted',
        'type': 'lock',
        'isToday': true,
        'isRead': false,
      },
      {
        'id': 'n2',
        'message': 'Accept your Privacy Policy change by Medicon authority.',
        'type': 'info',
        'isToday': true,
        'isRead': false,
      },
      {
        'id': 'n3',
        'message': 'Appointment Completed with doctor Tamim Ikraim',
        'type': 'calendar',
        'isToday': false,
        'isRead': true,
      },
    ];
    return rows.map(AppNotificationModel.fromMap).toList();
  }
}
