import '../entities/user_profile.dart';

abstract interface class AccountRepository {
  Future<UserProfile> getProfile();
}
