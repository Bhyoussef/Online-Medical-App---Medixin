import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class AccountRemoteDataSource {
  const AccountRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> profile() => _client.get(ApiEndpoints.profile);

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) =>
      _client.put(ApiEndpoints.profile, body: body);
}
