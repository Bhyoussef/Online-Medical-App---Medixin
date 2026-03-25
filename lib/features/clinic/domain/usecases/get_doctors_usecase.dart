import '../entities/doctor.dart';
import '../repositories/clinic_repository.dart';

class GetDoctorsUseCase {
  const GetDoctorsUseCase(this._repository);

  final ClinicRepository _repository;

  Future<List<Doctor>> call() => _repository.getDoctors();
}
