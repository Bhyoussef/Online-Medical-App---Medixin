import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/inbox_thread.dart';
import '../cubit/inbox_cubit.dart';
import '../cubit/inbox_state.dart';
import 'audio_call_page.dart';
import 'video_call_page.dart';

class TextMessagePage extends StatefulWidget {
  const TextMessagePage({super.key, required this.thread});

  final InboxThread thread;

  @override
  State<TextMessagePage> createState() => _TextMessagePageState();
}

class _TextMessagePageState extends State<TextMessagePage> {
  @override
  void initState() {
    super.initState();
    context.read<InboxCubit>().loadMessages(widget.thread.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.doctorName),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => AudioCallPage(thread: widget.thread),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => VideoCallPage(thread: widget.thread),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<InboxCubit, InboxState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: state.messages
                      .map(
                        (m) => Align(
                          alignment:
                              m.isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: m.isMe
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: m.type == 'image'
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(m.text,
                                        width: 120, height: 90, fit: BoxFit.cover),
                                  )
                                : Text(
                                    m.text,
                                    style: TextStyle(
                                      color: m.isMe ? Colors.white : Colors.black87,
                                    ),
                                  ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Type here...'),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  child: IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
