import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_remote_datasource.dart';
import '../models/user_profile_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._remote);

  final AccountRemoteDataSource _remote;

  @override
  Future<UserProfile> getProfile() async {
    final json = await _remote.profile();
    final data = (json['data'] as Map<String, dynamic>? ?? json);
    return UserProfileModel.fromMap(data);
  }
}
