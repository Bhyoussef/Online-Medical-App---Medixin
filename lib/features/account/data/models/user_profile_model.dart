import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.gender,
    required super.dob,
    required super.avatar,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) => UserProfileModel(
        name: map['name'] as String,
        email: map['email'] as String,
        phone: map['phone'] as String,
        gender: map['gender'] as String,
        dob: map['dob'] as String,
        avatar: map['avatar'] as String,
      );
}
