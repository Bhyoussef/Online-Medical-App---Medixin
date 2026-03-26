import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../account/presentation/pages/menu_page.dart';
import '../../../inbox/presentation/pages/inbox_page.dart';
import '../cubit/clinic_cubit.dart';
import '../cubit/clinic_state.dart';
import 'appointments_page.dart';
import 'doctors_page.dart';
import 'home_page.dart';

class ClinicShellPage extends StatefulWidget {
  const ClinicShellPage({super.key});

  @override
  State<ClinicShellPage> createState() => _ClinicShellPageState();
}

class _ClinicShellPageState extends State<ClinicShellPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClinicCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        final pages = [
          const HomePage(),
          const DoctorsPage(),
          const AppointmentsPage(),
          const InboxPage(),
          const MenuPage(),
        ];

        return Scaffold(
          body: state.isLoading && state.doctors.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : pages[state.selectedBottomIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.selectedBottomIndex,
            onTap: context.read<ClinicCubit>().changeBottomNav,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services_outlined), label: 'Doctors'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined), label: 'Appointments'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline), label: 'Inbox'),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Menu'),
            ],
          ),
        );
      },
    );
  }
}
