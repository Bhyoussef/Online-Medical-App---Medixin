import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.isSelected,
  });

  final String id;
  final String name;
  final String icon;
  final bool isSelected;

  PaymentMethod copyWith({bool? isSelected}) => PaymentMethod(
        id: id,
        name: name,
        icon: icon,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object?> get props => [id, name, icon, isSelected];
}
