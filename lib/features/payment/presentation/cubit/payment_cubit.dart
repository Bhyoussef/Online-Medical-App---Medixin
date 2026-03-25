import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_payment_methods_usecase.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._getPaymentMethodsUseCase) : super(PaymentState.initial());

  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;

  Future<void> load() async {
    final methods = await _getPaymentMethodsUseCase();
    emit(state.copyWith(methods: methods));
  }

  void selectMethod(String id) {
    final methods = state.methods
        .map((e) => e.copyWith(isSelected: e.id == id))
        .toList();
    emit(state.copyWith(methods: methods));
  }

  void updateVoucher(String value) => emit(state.copyWith(voucher: value));

  void applyVoucher() => emit(state.copyWith(isApplied: state.voucher.isNotEmpty));

  void goConfirm() => emit(state.copyWith(step: PaymentStep.confirm));
}
