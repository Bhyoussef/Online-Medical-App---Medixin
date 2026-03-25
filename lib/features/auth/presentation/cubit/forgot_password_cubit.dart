import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/request_reset_code_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_reset_code_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(
    this._requestResetCodeUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgotPasswordState.initial());

  final RequestResetCodeUseCase _requestResetCodeUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  void updateEmail(String value) => emit(state.copyWith(email: value, error: ''));

  void updateOtpDigit(int index, String value) {
    final otp = [...state.otp];
    otp[index] = value.isEmpty ? '' : value.substring(value.length - 1);
    emit(state.copyWith(otp: otp, error: ''));
  }

  void updateNewPassword(String value) =>
      emit(state.copyWith(newPassword: value, error: ''));

  void updateConfirmPassword(String value) =>
      emit(state.copyWith(confirmPassword: value, error: ''));

  void toggleNewPasswordVisibility() =>
      emit(state.copyWith(hideNewPassword: !state.hideNewPassword));

  void toggleConfirmPasswordVisibility() =>
      emit(state.copyWith(hideConfirmPassword: !state.hideConfirmPassword));

  Future<void> submitEmail() async {
    if (state.email.trim().isEmpty) {
      emit(state.copyWith(error: 'Email is required.'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: ''));
    try {
      await _requestResetCodeUseCase(email: state.email.trim());
      emit(state.copyWith(isLoading: false, step: ForgotStep.verification));
    } catch (_) {
      emit(state.copyWith(isLoading: false, error: 'Failed to send reset code.'));
    }
  }

  Future<void> submitOtp() async {
    if (state.otpCode.length != 4 || state.otp.contains('')) {
      emit(state.copyWith(error: 'Please enter the 4-digit code.'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: ''));
    final valid = await _verifyResetCodeUseCase(code: state.otpCode);

    if (!valid) {
      emit(state.copyWith(isLoading: false, error: 'Invalid code. Try 4913.'));
      return;
    }

    emit(state.copyWith(isLoading: false, step: ForgotStep.resetPassword));
  }

  Future<void> submitNewPassword() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      await _resetPasswordUseCase(
        newPassword: state.newPassword,
        confirmPassword: state.confirmPassword,
      );
      emit(state.copyWith(isLoading: false, error: 'Password reset successful.'));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Passwords must match and be at least 8 characters.',
        ),
      );
    }
  }

  void goBackStep() {
    switch (state.step) {
      case ForgotStep.email:
        return;
      case ForgotStep.verification:
        emit(state.copyWith(step: ForgotStep.email, error: ''));
      case ForgotStep.resetPassword:
        emit(state.copyWith(step: ForgotStep.verification, error: ''));
    }
  }
}
