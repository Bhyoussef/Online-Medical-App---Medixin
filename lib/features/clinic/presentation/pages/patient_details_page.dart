import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../payment/presentation/pages/payment_page.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  bool _filled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient’s Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Full Name', hintText: _filled ? 'Mizanur Rahman Abrar' : 'type patient’s fullname')),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Email', hintText: _filled ? 'mizanurrahman@gmail.com' : 'type patient’s email')),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Phone', hintText: _filled ? '+880 166 844 9222' : '+880 162 422 1012')),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Gender', hintText: _filled ? 'Male' : 'Choose patient’s gender')),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Age', hintText: _filled ? '21 Years, 250 Days' : 'type patient’s age')),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Visiting Purpose',
                hintText: _filled
                    ? 'I am orthodonist patient .I am feeling so pain in my backbone...'
                    : 'type visiting purpose...',
              ),
            ),
            const Spacer(),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => setState(() => _filled = !_filled),
                  child: Text(_filled ? 'CLEAR' : 'AUTOFILL'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppColors.gradientBlueTop, AppColors.primaryBlue]),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const PaymentPage()),
                        ),
                        child: const Text('CONTINUE', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
