import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../models/payment_method_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<List<PaymentMethod>> getMethods() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    const rows = [
      {'id': 'apple', 'name': 'Apple Pay', 'icon': '', 'isSelected': true},
      {'id': 'paypal', 'name': 'PayPal', 'icon': 'P', 'isSelected': false},
      {'id': 'gpay', 'name': 'Google Pay', 'icon': 'G', 'isSelected': false},
    ];
    return rows.map(PaymentMethodModel.fromMap).toList();
  }
}
