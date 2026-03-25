import '../entities/user_profile.dart';
import '../repositories/account_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);

  final AccountRepository _repository;

  Future<UserProfile> call() => _repository.getProfile();
}
