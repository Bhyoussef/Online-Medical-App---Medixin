import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/user_profile_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<UserProfile> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    return UserProfileModel.fromMap(const {
      'name': 'Rafi Islam Apon',
      'email': 'rafiislamapon4@gmail.com',
      'phone': '+880 162 422 1012',
      'gender': 'Male',
      'dob': '18 February, 2001',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
    });
  }
}
