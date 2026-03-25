import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String newPassword,
    required String confirmPassword,
  }) {
    return _repository.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
