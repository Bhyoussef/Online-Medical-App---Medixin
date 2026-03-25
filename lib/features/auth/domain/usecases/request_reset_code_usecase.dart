import '../repositories/auth_repository.dart';

class RequestResetCodeUseCase {
  const RequestResetCodeUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call({required String email}) {
    return _repository.requestResetCode(email: email);
  }
}
