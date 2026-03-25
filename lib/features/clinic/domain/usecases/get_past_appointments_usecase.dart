import '../entities/appointment.dart';
import '../repositories/clinic_repository.dart';

class GetPastAppointmentsUseCase {
  const GetPastAppointmentsUseCase(this._repository);

  final ClinicRepository _repository;

  Future<List<Appointment>> call() => _repository.getPastAppointments();
}
