import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class NotificationRemoteDataSource {
  const NotificationRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> list({int page = 1}) {
    return _client.get(ApiEndpoints.notifications, query: {'page': page});
  }

  Future<void> markAllRead() async {
    await _client.put('${ApiEndpoints.notifications}/read-all');
  }
}
