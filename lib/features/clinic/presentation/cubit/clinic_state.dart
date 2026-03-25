import 'package:equatable/equatable.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';

enum AppointmentTab { upcoming, past }

class ClinicState extends Equatable {
  const ClinicState({
    required this.isLoading,
    required this.doctors,
    required this.upcoming,
    required this.past,
    required this.selectedBottomIndex,
    required this.appointmentTab,
    required this.error,
  });

  factory ClinicState.initial() => const ClinicState(
        isLoading: false,
        doctors: [],
        upcoming: [],
        past: [],
        selectedBottomIndex: 0,
        appointmentTab: AppointmentTab.upcoming,
        error: '',
      );

  final bool isLoading;
  final List<Doctor> doctors;
  final List<Appointment> upcoming;
  final List<Appointment> past;
  final int selectedBottomIndex;
  final AppointmentTab appointmentTab;
  final String error;

  ClinicState copyWith({
    bool? isLoading,
    List<Doctor>? doctors,
    List<Appointment>? upcoming,
    List<Appointment>? past,
    int? selectedBottomIndex,
    AppointmentTab? appointmentTab,
    String? error,
  }) {
    return ClinicState(
      isLoading: isLoading ?? this.isLoading,
      doctors: doctors ?? this.doctors,
      upcoming: upcoming ?? this.upcoming,
      past: past ?? this.past,
      selectedBottomIndex: selectedBottomIndex ?? this.selectedBottomIndex,
      appointmentTab: appointmentTab ?? this.appointmentTab,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        doctors,
        upcoming,
        past,
        selectedBottomIndex,
        appointmentTab,
        error,
      ];
}
