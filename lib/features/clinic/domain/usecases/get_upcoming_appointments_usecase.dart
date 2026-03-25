import '../entities/appointment.dart';
import '../repositories/clinic_repository.dart';

class GetUpcomingAppointmentsUseCase {
  const GetUpcomingAppointmentsUseCase(this._repository);

  final ClinicRepository _repository;

  Future<List<Appointment>> call() => _repository.getUpcomingAppointments();
}
