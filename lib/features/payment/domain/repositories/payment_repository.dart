import '../entities/payment_method.dart';

abstract interface class PaymentRepository {
  Future<List<PaymentMethod>> getMethods();
}
