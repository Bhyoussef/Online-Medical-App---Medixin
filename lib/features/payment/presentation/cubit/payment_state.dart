import 'package:equatable/equatable.dart';

import '../../domain/entities/payment_method.dart';

enum PaymentStep { checkout, confirm }

class PaymentState extends Equatable {
  const PaymentState({
    required this.methods,
    required this.voucher,
    required this.isApplied,
    required this.step,
  });

  factory PaymentState.initial() => const PaymentState(
        methods: [],
        voucher: '',
        isApplied: false,
        step: PaymentStep.checkout,
      );

  final List<PaymentMethod> methods;
  final String voucher;
  final bool isApplied;
  final PaymentStep step;

  PaymentState copyWith({
    List<PaymentMethod>? methods,
    String? voucher,
    bool? isApplied,
    PaymentStep? step,
  }) {
    return PaymentState(
      methods: methods ?? this.methods,
      voucher: voucher ?? this.voucher,
      isApplied: isApplied ?? this.isApplied,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [methods, voucher, isApplied, step];
}
