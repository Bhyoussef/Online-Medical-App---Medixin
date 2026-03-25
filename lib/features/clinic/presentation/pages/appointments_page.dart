import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/clinic_cubit.dart';
import '../cubit/clinic_state.dart';
import '../widgets/appointment_card.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ClinicCubit, ClinicState>(
        builder: (context, state) {
          final isUpcoming = state.appointmentTab == AppointmentTab.upcoming;
          final items = isUpcoming ? state.upcoming : state.past;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('My Appointment', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Upcoming'),
                        selected: isUpcoming,
                        onSelected: (_) => context.read<ClinicCubit>().changeAppointmentTab(AppointmentTab.upcoming),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Past'),
                        selected: !isUpcoming,
                        onSelected: (_) => context.read<ClinicCubit>().changeAppointmentTab(AppointmentTab.past),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) => AppointmentCard(
                      appointment: items[index],
                      isPast: !isUpcoming,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
