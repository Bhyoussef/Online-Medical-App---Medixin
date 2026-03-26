import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.location,
  });

  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String location;

  @override
  List<Object?> get props => [id, name, specialty, imageUrl, rating, location];
}
