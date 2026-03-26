import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/inbox_cubit.dart';
import '../cubit/inbox_state.dart';
import 'text_message_page.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  void initState() {
    super.initState();
    context.read<InboxCubit>().loadThreads();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Message', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              ...state.threads.map(
                (thread) => ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => TextMessagePage(thread: thread),
                    ),
                  ),
                  leading: CircleAvatar(backgroundImage: NetworkImage(thread.imageUrl)),
                  title: Text(thread.doctorName, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(thread.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Column(
                    children: [
                      Text(thread.time, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 6),
                      if (thread.unreadCount > 0)
                        CircleAvatar(
                          radius: 10,
                          child: Text('${thread.unreadCount}', style: const TextStyle(fontSize: 10)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
