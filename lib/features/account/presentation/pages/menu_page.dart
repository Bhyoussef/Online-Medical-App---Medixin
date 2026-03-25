import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'settings_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Profile', Icons.person),
      ('My Appointment', Icons.calendar_month),
      ('Payment Method', Icons.wallet),
      ('Settings', Icons.settings),
      ('Help & Support', Icons.info),
      ('Log Out', Icons.logout),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.gradientBlueTop, AppColors.primaryBlue],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(width: 56, child: Divider(color: Colors.white)),
                  ...items.map(
                    (e) => ListTile(
                      onTap: e.$1 == 'Settings'
                          ? () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const SettingsPage(),
                                ),
                              )
                          : null,
                      leading: Icon(e.$2, color: Colors.white),
                      title: Text(e.$1,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
