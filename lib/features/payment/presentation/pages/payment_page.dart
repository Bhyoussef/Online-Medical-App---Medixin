import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../clinic/presentation/pages/appointment_complete_page.dart';
import '../cubit/payment_cubit.dart';
import '../cubit/payment_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final voucherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().load();
  }

  @override
  void dispose() {
    voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Payment Method',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    Spacer(),
                    Text('Add New Card', style: TextStyle(color: AppColors.primaryBlue)),
                  ],
                ),
                const SizedBox(height: 12),
                ...state.methods.map(
                  (e) => GestureDetector(
                    onTap: () => context.read<PaymentCubit>().selectMethod(e.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: e.isSelected
                              ? AppColors.primaryBlue
                              : const Color(0xFFE5E7EB),
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Text(e.icon, style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 16),
                          Text(e.name, style: const TextStyle(fontSize: 16)),
                          const Spacer(),
                          Icon(
                            e.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (state.step == PaymentStep.confirm)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF45C0DE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Balance', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 8),
                        Text('\$ 3,403.09',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 18),
                        Text('MizanurAbrar',
                            style: TextStyle(color: Colors.white, fontSize: 26)),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                const Text('Add Voucher',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: voucherController,
                        onChanged: context.read<PaymentCubit>().updateVoucher,
                        decoration:
                            const InputDecoration(hintText: 'VOUCHER CODE'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: context.read<PaymentCubit>().applyVoucher,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF59E0B),
                        ),
                        child: const Text('APPLY'),
                      ),
                    ),
                  ],
                ),
                if (state.isApplied) ...[
                  const SizedBox(height: 10),
                  const Text('Applied voucher: EidMubarak22 (25% off)'),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.gradientBlueTop, AppColors.primaryBlue],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (state.step == PaymentStep.checkout) {
                          context.read<PaymentCubit>().goConfirm();
                          return;
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (_) => const AppointmentCompletePage(),
                          ),
                        );
                      },
                      child: Text(
                        state.step == PaymentStep.checkout ? 'CHECKOUT' : 'CONFIRM',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
