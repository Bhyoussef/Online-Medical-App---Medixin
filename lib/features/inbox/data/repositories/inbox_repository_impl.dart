import '../../domain/entities/chat_message.dart';
import '../../domain/entities/inbox_thread.dart';
import '../../domain/repositories/inbox_repository.dart';
import '../models/chat_message_model.dart';
import '../models/inbox_thread_model.dart';

class InboxRepositoryImpl implements InboxRepository {
  @override
  Future<List<InboxThread>> getThreads() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    const rows = [
      {
        'id': 't1',
        'doctorName': 'Dr. Tasnim Mridha',
        'preview': 'Hows about your health?',
        'time': 'Just now',
        'imageUrl': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=120&q=80',
        'unreadCount': 2,
      },
      {
        'id': 't2',
        'doctorName': 'Dr. Zubaear Rahim',
        'preview': 'Never miss any...',
        'time': 'Just now',
        'imageUrl': 'https://images.unsplash.com/photo-1594824475317-9d1f6be6a1d2?auto=format&fit=crop&w=120&q=80',
        'unreadCount': 1,
      },
    ];
    return rows.map(InboxThreadModel.fromMap).toList();
  }

  @override
  Future<List<ChatMessage>> getMessages(String threadId) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    const rows = [
      {
        'id': 'm1',
        'text': 'I have seen some strange redness on your fingers .How is that?',
        'isMe': false,
        'type': 'text',
        'time': '9:26 am',
      },
      {
        'id': 'm2',
        'text': 'Yeah I show you, This is the finger',
        'isMe': true,
        'type': 'text',
        'time': '9:27 am',
      },
      {
        'id': 'm3',
        'text': 'https://images.unsplash.com/photo-1579154204601-01588f351e67?auto=format&fit=crop&w=300&q=80',
        'isMe': true,
        'type': 'image',
        'time': '9:27 am',
      },
      {
        'id': 'm4',
        'text': 'This is too much curing in hand, you have to make a X-ray',
        'isMe': false,
        'type': 'text',
        'time': '9:28 am',
      },
    ];
    return rows.map(ChatMessageModel.fromMap).toList();
  }
}
