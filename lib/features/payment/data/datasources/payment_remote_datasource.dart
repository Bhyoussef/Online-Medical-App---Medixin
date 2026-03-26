import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class PaymentRemoteDataSource {
  const PaymentRemoteDataSource(this._client);

  final DioClient _client;

  Future<Map<String, dynamic>> methods() => _client.get(ApiEndpoints.paymentMethods);

  Future<Map<String, dynamic>> checkout(Map<String, dynamic> body) =>
      _client.post(ApiEndpoints.checkout, body: body);

  Future<Map<String, dynamic>> voucherPreview(String code) =>
      _client.post('/payments/voucher/preview', body: {'code': code});
}
