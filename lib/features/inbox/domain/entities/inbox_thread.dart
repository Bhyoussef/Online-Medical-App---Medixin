import 'package:equatable/equatable.dart';

class InboxThread extends Equatable {
  const InboxThread({
    required this.id,
    required this.doctorName,
    required this.preview,
    required this.time,
    required this.imageUrl,
    required this.unreadCount,
  });

  final String id;
  final String doctorName;
  final String preview;
  final String time;
  final String imageUrl;
  final int unreadCount;

  @override
  List<Object?> get props => [id, doctorName, preview, time, imageUrl, unreadCount];
}
