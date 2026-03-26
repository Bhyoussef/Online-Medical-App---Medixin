import '../../domain/entities/payment_method.dart';

class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.isSelected,
  });

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) => PaymentMethodModel(
        id: map['id'] as String,
        name: map['name'] as String,
        icon: map['icon'] as String,
        isSelected: map['isSelected'] as bool,
      );
}
