import 'package:equatable/equatable.dart';

enum ForgotStep { email, verification, resetPassword }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.step,
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
    required this.hideNewPassword,
    required this.hideConfirmPassword,
    required this.isLoading,
    required this.error,
  });

  factory ForgotPasswordState.initial() {
    return const ForgotPasswordState(
      step: ForgotStep.email,
      email: '',
      otp: ['', '', '', ''],
      newPassword: '',
      confirmPassword: '',
      hideNewPassword: true,
      hideConfirmPassword: true,
      isLoading: false,
      error: '',
    );
  }

  final ForgotStep step;
  final String email;
  final List<String> otp;
  final String newPassword;
  final String confirmPassword;
  final bool hideNewPassword;
  final bool hideConfirmPassword;
  final bool isLoading;
  final String error;

  String get otpCode => otp.join();

  ForgotPasswordState copyWith({
    ForgotStep? step,
    String? email,
    List<String>? otp,
    String? newPassword,
    String? confirmPassword,
    bool? hideNewPassword,
    bool? hideConfirmPassword,
    bool? isLoading,
    String? error,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      hideNewPassword: hideNewPassword ?? this.hideNewPassword,
      hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        step,
        email,
        otp,
        newPassword,
        confirmPassword,
        hideNewPassword,
        hideConfirmPassword,
        isLoading,
        error,
      ];
}
