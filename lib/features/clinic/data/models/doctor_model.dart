import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialty,
    required super.imageUrl,
    required super.rating,
    required super.location,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) => DoctorModel(
        id: map['id'] as String,
        name: map['name'] as String,
        specialty: map['specialty'] as String,
        imageUrl: map['imageUrl'] as String,
        rating: map['rating'] as double,
        location: map['location'] as String,
      );
}
