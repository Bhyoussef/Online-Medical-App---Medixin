import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class ClinicRemoteDataSource {
  const ClinicRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> doctors({Map<String, dynamic>? query}) {
    return _client.get(ApiEndpoints.doctors, query: query);
  }

  Future<Map<String, dynamic>> appointments({required String tab, int page = 1}) {
    return _client.get(ApiEndpoints.appointments, query: {'tab': tab, 'page': page});
  }

  Future<Map<String, dynamic>> createAppointment(Map<String, dynamic> body) {
    return _client.post(ApiEndpoints.appointments, body: body);
  }
}
