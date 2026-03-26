import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'clinic_shell_page.dart';

class AppointmentCompletePage extends StatelessWidget {
  const AppointmentCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 70),
              ),
              const SizedBox(height: 20),
              const Text('Congratulation!', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Hey Rafi, your appointment has been created.', textAlign: TextAlign.center),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.gradientBlueTop, AppColors.primaryBlue]),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    child: const Text('SEE APPOINTMENT', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(builder: (_) => const ClinicShellPage()),
                    (route) => false,
                  ),
                  child: const Text('DASHBOARD'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
