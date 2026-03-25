import '../../domain/entities/inbox_thread.dart';

class InboxThreadModel extends InboxThread {
  const InboxThreadModel({
    required super.id,
    required super.doctorName,
    required super.preview,
    required super.time,
    required super.imageUrl,
    required super.unreadCount,
  });

  factory InboxThreadModel.fromMap(Map<String, dynamic> map) => InboxThreadModel(
        id: map['id'] as String,
        doctorName: map['doctorName'] as String,
        preview: map['preview'] as String,
        time: map['time'] as String,
        imageUrl: map['imageUrl'] as String,
        unreadCount: map['unreadCount'] as int,
      );
}
