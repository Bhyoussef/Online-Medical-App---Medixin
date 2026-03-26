import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/doctor.dart';
import 'patient_details_page.dart';

class AppointmentBookingPage extends StatelessWidget {
  const AppointmentBookingPage({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Chip(label: Text('Hospital')),
                SizedBox(width: 8),
                Chip(label: Text('Online')),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Select Schedule',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(8, (i) => Chip(label: Text('${8 + i}:00 am'))),
            ),
            const SizedBox(height: 16),
            const Text('Consultation Fees',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [Text('Messaging'), Text('\$5')],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [Text('Voice Call'), Text('\$10')],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [Text('Video Call'), Text('\$20')],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.gradientBlueTop, AppColors.primaryBlue]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const PatientDetailsPage()),
                  ),
                  child:
                      const Text('CONTINUE', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
