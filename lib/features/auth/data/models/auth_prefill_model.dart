import '../../domain/entities/auth_prefill.dart';

class AuthPrefillModel extends AuthPrefill {
  const AuthPrefillModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });

  factory AuthPrefillModel.fromMap(Map<String, dynamic> map) {
    return AuthPrefillModel(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }
}
