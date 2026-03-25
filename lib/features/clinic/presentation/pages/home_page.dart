import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/clinic_cubit.dart';
import '../cubit/clinic_state.dart';
import '../widgets/doctor_card.dart';
import 'doctor_details_page.dart';
import '../../../notification/presentation/pages/notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ClinicCubit, ClinicState>(
        builder: (context, state) {
          final topDoctor = state.doctors.isNotEmpty ? state.doctors.first : null;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, James!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                        Text('Dhaka, Bangladesh', style: TextStyle(color: Color(0xFF6B7280))),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => const NotificationPage()),
                    ),
                    icon: const Icon(Icons.notifications_none, color: AppColors.primaryBlue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.gradientBlueTop, AppColors.primaryBlue]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upcoming Schedule', style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Text('Dr. Tasnim Mridha',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    Text('Mon, Oct 17, 08.00am - 10am', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text('Top Doctor', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              if (topDoctor != null)
                DoctorCard(
                  doctor: topDoctor,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => DoctorDetailsPage(doctor: topDoctor),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
