import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/clinic_cubit.dart';
import '../cubit/clinic_state.dart';
import '../widgets/doctor_card.dart';
import 'doctor_details_page.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ClinicCubit, ClinicState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('Specialist', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 14),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Chip(label: Text('Dermatologist')),
                    SizedBox(width: 8),
                    Chip(label: Text('Heart surgeon')),
                    SizedBox(width: 8),
                    Chip(label: Text('Neurology')),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ...state.doctors.map(
                (doctor) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DoctorCard(
                    doctor: doctor,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => DoctorDetailsPage(doctor: doctor),
                      ),
                    ),
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
