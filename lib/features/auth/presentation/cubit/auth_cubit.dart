import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_auth_prefill_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._getAuthPrefillUseCase) : super(AuthState.initial());

  final GetAuthPrefillUseCase _getAuthPrefillUseCase;

  void switchMode(AuthMode mode) {
    emit(
      state.copyWith(
        mode: mode,
        fullName: '',
        email: '',
        password: '',
        confirmPassword: '',
        rememberMe: false,
        error: '',
      ),
    );
  }

  void updateFullName(String value) => emit(state.copyWith(fullName: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updatePassword(String value) => emit(state.copyWith(password: value));
  void updateConfirmPassword(String value) =>
      emit(state.copyWith(confirmPassword: value));

  void toggleRememberMe() => emit(state.copyWith(rememberMe: !state.rememberMe));

  void togglePasswordVisibility() =>
      emit(state.copyWith(hidePassword: !state.hidePassword));

  void toggleConfirmPasswordVisibility() => emit(
        state.copyWith(hideConfirmPassword: !state.hideConfirmPassword),
      );

  Future<void> autofill() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final prefill = state.mode == AuthMode.signIn
          ? await _getAuthPrefillUseCase.signIn()
          : await _getAuthPrefillUseCase.signUp();

      emit(
        state.copyWith(
          fullName: prefill.fullName,
          email: prefill.email,
          password: prefill.password,
          confirmPassword: prefill.confirmPassword,
          rememberMe: state.mode == AuthMode.signIn,
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Could not load mock credentials. Please try again.',
        ),
      );
    }
  }
}
