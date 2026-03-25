import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.doctorName,
    required super.specialty,
    required super.imageUrl,
    required super.time,
    required super.status,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) => AppointmentModel(
        id: map['id'] as String,
        doctorName: map['doctorName'] as String,
        specialty: map['specialty'] as String,
        imageUrl: map['imageUrl'] as String,
        time: map['time'] as String,
        status: map['status'] as String,
      );
}
