import '../entities/auth_prefill.dart';

abstract interface class AuthRepository {
  Future<AuthPrefill> getSignInPrefill();
  Future<AuthPrefill> getSignUpPrefill();

  Future<void> requestResetCode({required String email});
  Future<bool> verifyResetCode({required String code});
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });
}
