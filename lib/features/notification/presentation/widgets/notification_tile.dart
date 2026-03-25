import 'package:flutter/material.dart';

import '../../domain/entities/app_notification.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.item});

  final AppNotification item;

  @override
  Widget build(BuildContext context) {
    final icon = switch (item.type) {
      'lock' => Icons.lock,
      'calendar' => Icons.calendar_month,
      _ => Icons.info,
    };

    final bg = switch (item.type) {
      'lock' => const Color(0xFFDDEAFF),
      'calendar' => const Color(0xFFFFF3D7),
      _ => const Color(0xFFDDF7FF),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: bg, child: Icon(icon, color: Colors.blue)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
