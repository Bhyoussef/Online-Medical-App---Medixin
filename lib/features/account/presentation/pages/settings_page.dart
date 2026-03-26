import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    const options = [
      'Upgrade',
      'Password',
      'Notification',
      'Payment',
      'Favourite Doctor',
      'Language',
      'FAQ',
      'Support',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          final p = state.profile;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (p != null)
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(p.avatar)),
                  title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(p.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => const EditProfilePage()),
                    ),
                  ),
                ),
              const Divider(),
              ...options.map(
                (e) => ListTile(
                  leading: const Icon(Icons.circle, size: 12),
                  title: Text(e),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
