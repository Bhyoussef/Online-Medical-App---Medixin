import 'package:equatable/equatable.dart';

class AuthPrefill extends Equatable {
  const AuthPrefill({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [fullName, email, password, confirmPassword];
}
