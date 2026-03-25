import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/notification_cubit.dart';
import '../cubit/notification_state.dart';
import '../widgets/notification_tile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Notification'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.notifications_off_outlined, size: 88, color: Colors.blue),
                  SizedBox(height: 14),
                  Text('Ups! There is no notification',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  SizedBox(height: 8),
                  Text(
                    'You’ll be notified about activity on tasks\nyou’re a collaborator on.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            );
          }

          final today = state.items.where((e) => e.isToday).toList();
          final yesterday = state.items.where((e) => !e.isToday).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const Text('Today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text('(${today.length})', style: const TextStyle(color: Colors.blue)),
                  const Spacer(),
                  TextButton(
                    onPressed: context.read<NotificationCubit>().markAllRead,
                    child: const Text('MARK ALL AS READ'),
                  ),
                ],
              ),
              ...today.map((e) => NotificationTile(item: e)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Yesterday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text('(${yesterday.length})', style: const TextStyle(color: Colors.blue)),
                ],
              ),
              ...yesterday.map((e) => NotificationTile(item: e)),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: context.read<NotificationCubit>().clearAll,
                child: const Text('CLEAR ALL (SHOW EMPTY STATE)'),
              ),
            ],
          );
        },
      ),
    );
  }
}
