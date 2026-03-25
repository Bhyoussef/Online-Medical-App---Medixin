import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key, required this.cubit});

  final ForgotPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatelessWidget {
  const _ForgotPasswordView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            final cubit = context.read<ForgotPasswordCubit>();
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (state.step == ForgotStep.email) {
                        Navigator.maybePop(context);
                        return;
                      }
                      cubit.goBackStep();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(height: 12),
                  if (state.step == ForgotStep.email) ...[
                    const _Header(
                      title: 'Reset Password',
                      subtitle:
                          'Please enter your email address to request a password reset',
                    ),
                    const SizedBox(height: 20),
                    const _Label('Email'),
                    AuthTextField(
                      hint: 'type your email',
                      controller: TextEditingController(text: state.email),
                      prefixIcon: Icons.mail_outline,
                      onChanged: cubit.updateEmail,
                    ),
                  ] else if (state.step == ForgotStep.verification) ...[
                    const _Header(
                      title: 'Verification',
                      subtitle:
                          'We’ve send you the verification code on rafiislamapon4@gmail.com',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => _OtpBox(
                          initialValue: state.otp[index],
                          onChanged: (value) => cubit.updateOtpDigit(index, value),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Get Code in 0:57 ',
                              style: TextStyle(color: Color(0xFF9CA3AF)),
                            ),
                            TextSpan(
                              text: 'RESEND',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    const _Header(
                      title: 'Reset Password',
                      subtitle:
                          'Set new password for your next login & access in Medixin.',
                    ),
                    const SizedBox(height: 20),
                    const _Label('Password', isRequired: true),
                    AuthTextField(
                      hint: 'Type your password',
                      controller: TextEditingController(text: state.newPassword),
                      prefixIcon: Icons.lock_outline,
                      obscureText: state.hideNewPassword,
                      onToggleVisibility: cubit.toggleNewPasswordVisibility,
                      onChanged: cubit.updateNewPassword,
                    ),
                    const SizedBox(height: 16),
                    const _Label('Confirm Password', isRequired: true),
                    AuthTextField(
                      hint: 'Re-type your password',
                      controller: TextEditingController(text: state.confirmPassword),
                      prefixIcon: Icons.lock_outline,
                      obscureText: state.hideConfirmPassword,
                      onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
                      onChanged: cubit.updateConfirmPassword,
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.gradientBlueTop, AppColors.primaryBlue],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        onPressed: state.isLoading
                            ? null
                            : switch (state.step) {
                                ForgotStep.email => cubit.submitEmail,
                                ForgotStep.verification => cubit.submitOtp,
                                ForgotStep.resetPassword => cubit.submitNewPassword,
                              },
                        child: state.isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                state.step == ForgotStep.resetPassword
                                    ? 'RESET NOW'
                                    : 'SEND',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {this.isRequired = false});

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Color(0xFFEF4444), fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({required this.initialValue, required this.onChanged});

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      child: TextFormField(
        initialValue: initialValue,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryBlue),
          ),
        ),
      ),
    );
  }
}
