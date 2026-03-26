import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.avatar,
  });

  final String name;
  final String email;
  final String phone;
  final String gender;
  final String dob;
  final String avatar;

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? dob,
  }) => UserProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        avatar: avatar,
      );

  @override
  List<Object?> get props => [name, email, phone, gender, dob, avatar];
}
