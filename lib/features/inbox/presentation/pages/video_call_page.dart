import 'package:flutter/material.dart';

import '../../domain/entities/inbox_thread.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key, required this.thread});

  final InboxThread thread;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(thread.imageUrl, fit: BoxFit.cover),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    const Spacer(),
                    Container(
                      width: 80,
                      height: 120,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(thread.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(thread.doctorName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Text('6.40', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.86),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
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
        ],
      ),
    );
  }
}
