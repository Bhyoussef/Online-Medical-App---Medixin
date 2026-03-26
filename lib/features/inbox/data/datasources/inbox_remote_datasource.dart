import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class InboxRemoteDataSource {
  const InboxRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> threads() => _client.get(ApiEndpoints.inboxThreads);

  Future<Map<String, dynamic>> messages(String threadId, {int page = 1}) {
    return _client.get('${ApiEndpoints.inboxThreads}/$threadId/messages', query: {'page': page});
  }

  Future<Map<String, dynamic>> sendMessage(String threadId, Map<String, dynamic> body) {
    return _client.post('${ApiEndpoints.inboxThreads}/$threadId/messages', body: body);
  }
}
