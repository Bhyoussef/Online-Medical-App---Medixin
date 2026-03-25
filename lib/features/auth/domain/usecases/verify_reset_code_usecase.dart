import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  const VerifyResetCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<bool> call({required String code}) {
    return _repository.verifyResetCode(code: code);
  }
}
