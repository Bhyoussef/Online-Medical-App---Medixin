import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) {
    return _client.post(
      ApiEndpoints.login,
      body: {'email': email, 'password': password},
    );
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> payload) {
    return _client.post(ApiEndpoints.register, body: payload);
  }

  Future<void> requestResetCode(String email) async {
    await _client.post('/auth/forgot-password', body: {'email': email});
  }

  Future<void> resetPassword(Map<String, dynamic> payload) async {
    await _client.post('/auth/reset-password', body: payload);
  }
}
