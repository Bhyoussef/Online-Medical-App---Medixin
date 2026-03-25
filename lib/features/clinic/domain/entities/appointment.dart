import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.imageUrl,
    required this.time,
    required this.status,
  });

  final String id;
  final String doctorName;
  final String specialty;
  final String imageUrl;
  final String time;
  final String status;

  @override
  List<Object?> get props => [id, doctorName, specialty, imageUrl, time, status];
}
