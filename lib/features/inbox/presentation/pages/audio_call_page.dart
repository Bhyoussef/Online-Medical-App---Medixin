import 'package:flutter/material.dart';

import '../../domain/entities/inbox_thread.dart';

class AudioCallPage extends StatelessWidget {
  const AudioCallPage({super.key, required this.thread});

  final InboxThread thread;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back_ios_new)),
            const SizedBox(height: 30),
            Text(thread.doctorName, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700)),
            const Text('Calling...'),
            const Spacer(),
            CircleAvatar(radius: 70, backgroundImage: NetworkImage(thread.imageUrl)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.chat_bubble_outline, color: Colors.white),
                  const Icon(Icons.mic, color: Colors.white),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.call_end, color: Colors.white),
                    ),
                  ),
                  const Icon(Icons.videocam, color: Colors.white),
                  const Icon(Icons.volume_up, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
