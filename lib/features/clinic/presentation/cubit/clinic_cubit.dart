import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_doctors_usecase.dart';
import '../../domain/usecases/get_past_appointments_usecase.dart';
import '../../domain/usecases/get_upcoming_appointments_usecase.dart';
import 'clinic_state.dart';

class ClinicCubit extends Cubit<ClinicState> {
  ClinicCubit(
    this._getDoctorsUseCase,
    this._getUpcomingAppointmentsUseCase,
    this._getPastAppointmentsUseCase,
  ) : super(ClinicState.initial());

  final GetDoctorsUseCase _getDoctorsUseCase;
  final GetUpcomingAppointmentsUseCase _getUpcomingAppointmentsUseCase;
  final GetPastAppointmentsUseCase _getPastAppointmentsUseCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final doctors = await _getDoctorsUseCase();
      final upcoming = await _getUpcomingAppointmentsUseCase();
      final past = await _getPastAppointmentsUseCase();
      emit(
        state.copyWith(
          isLoading: false,
          doctors: doctors,
          upcoming: upcoming,
          past: past,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load clinic data'));
    }
  }

  void changeBottomNav(int index) {
    emit(state.copyWith(selectedBottomIndex: index));
  }

  void changeAppointmentTab(AppointmentTab tab) {
    emit(state.copyWith(appointmentTab: tab));
  }
}
