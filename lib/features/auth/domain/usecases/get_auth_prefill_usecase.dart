import '../entities/auth_prefill.dart';
import '../repositories/auth_repository.dart';

class GetAuthPrefillUseCase {
  const GetAuthPrefillUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthPrefill> signIn() => _repository.getSignInPrefill();

  Future<AuthPrefill> signUp() => _repository.getSignUpPrefill();
}
