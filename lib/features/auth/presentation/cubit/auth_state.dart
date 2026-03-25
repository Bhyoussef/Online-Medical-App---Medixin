import 'package:equatable/equatable.dart';

enum AuthMode { signIn, signUp }

class AuthState extends Equatable {
  const AuthState({
    required this.mode,
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.rememberMe,
    required this.hidePassword,
    required this.hideConfirmPassword,
    required this.isLoading,
    required this.error,
  });

  factory AuthState.initial() {
    return const AuthState(
      mode: AuthMode.signIn,
      fullName: '',
      email: '',
      password: '',
      confirmPassword: '',
      rememberMe: false,
      hidePassword: true,
      hideConfirmPassword: true,
      isLoading: false,
      error: '',
    );
  }

  final AuthMode mode;
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool rememberMe;
  final bool hidePassword;
  final bool hideConfirmPassword;
  final bool isLoading;
  final String error;

  AuthState copyWith({
    AuthMode? mode,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? rememberMe,
    bool? hidePassword,
    bool? hideConfirmPassword,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      mode: mode ?? this.mode,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      rememberMe: rememberMe ?? this.rememberMe,
      hidePassword: hidePassword ?? this.hidePassword,
      hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        mode,
        fullName,
        email,
        password,
        confirmPassword,
        rememberMe,
        hidePassword,
        hideConfirmPassword,
        isLoading,
        error,
      ];
}
