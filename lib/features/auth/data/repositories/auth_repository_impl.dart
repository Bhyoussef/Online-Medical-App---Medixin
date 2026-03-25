import '../../domain/entities/auth_prefill.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_prefill_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const String _mockOtpCode = '4913';

  @override
  Future<AuthPrefill> getSignInPrefill() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return AuthPrefillModel.fromMap(const {
      'fullName': '',
      'email': 'rafiislamapon4@gmail.com',
      'password': '12345678',
      'confirmPassword': '',
    });
  }

  @override
  Future<AuthPrefill> getSignUpPrefill() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return AuthPrefillModel.fromMap(const {
      'fullName': 'MD Rafi Islam Apon',
      'email': 'rafiislamapon4@gmail.com',
      'password': '12345678',
      'confirmPassword': '12345678',
    });
  }

  @override
  Future<void> requestResetCode({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<bool> verifyResetCode({required String code}) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return code == _mockOtpCode;
  }

  @override
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (newPassword != confirmPassword || newPassword.length < 8) {
      throw Exception('Invalid password');
    }
  }
}
