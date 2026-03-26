import '../entities/appointment.dart';
import '../entities/doctor.dart';

abstract interface class ClinicRepository {
  Future<List<Doctor>> getDoctors();
  Future<List<Appointment>> getUpcomingAppointments();
  Future<List<Appointment>> getPastAppointments();
}
