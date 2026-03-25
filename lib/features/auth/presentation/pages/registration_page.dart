import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../onboarding/presentation/widgets/app_logo.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_text_field.dart';
import 'forgot_password_page.dart';
import '../cubit/forgot_password_cubit.dart';
import '../widgets/social_button.dart';
import '../../../clinic/presentation/pages/clinic_shell_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: const _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatefulWidget {
  const _RegistrationView();

  @override
  State<_RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<_RegistrationView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            _fullNameController.value = _fullNameController.value.copyWith(
              text: state.fullName,
              selection: TextSelection.collapsed(offset: state.fullName.length),
            );
            _emailController.value = _emailController.value.copyWith(
              text: state.email,
              selection: TextSelection.collapsed(offset: state.email.length),
            );
            _passwordController.value = _passwordController.value.copyWith(
              text: state.password,
              selection: TextSelection.collapsed(offset: state.password.length),
            );
            _confirmPasswordController.value =
                _confirmPasswordController.value.copyWith(
              text: state.confirmPassword,
              selection:
                  TextSelection.collapsed(offset: state.confirmPassword.length),
            );

            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            final isSignIn = state.mode == AuthMode.signIn;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(height: 12),
                  const Center(child: AppLogo(isBlueBackground: false)),
                  const SizedBox(height: 30),
                  Text(
                    isSignIn ? 'Sign in' : 'Sign up',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isSignIn
                        ? 'Give credential to sign in your account'
                        : 'Give credential to sign up your account',
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (!isSignIn) ...[
                    const _FieldLabel('Full Name', isRequired: true),
                    AuthTextField(
                      hint: 'type your fullname',
                      controller: _fullNameController,
                      prefixIcon: Icons.person_outline,
                      onChanged: context.read<AuthCubit>().updateFullName,
                    ),
                    const SizedBox(height: 18),
                  ],
                  _FieldLabel('Email', isRequired: !isSignIn),
                  AuthTextField(
                    hint: isSignIn ? "type patient's email" : 'type your email',
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline,
                    onChanged: context.read<AuthCubit>().updateEmail,
                  ),
                  const SizedBox(height: 18),
                  _FieldLabel('Password', isRequired: !isSignIn),
                  AuthTextField(
                    hint: 'Type your password',
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: state.hidePassword,
                    onToggleVisibility:
                        context.read<AuthCubit>().togglePasswordVisibility,
                    onChanged: context.read<AuthCubit>().updatePassword,
                  ),
                  if (!isSignIn) ...[
                    const SizedBox(height: 18),
                    const _FieldLabel('Confirm Password', isRequired: true),
                    AuthTextField(
                      hint: 'Re-type your password',
                      controller: _confirmPasswordController,
                      prefixIcon: Icons.lock_outline,
                      obscureText: state.hideConfirmPassword,
                      onToggleVisibility:
                          context.read<AuthCubit>().toggleConfirmPasswordVisibility,
                      onChanged: context.read<AuthCubit>().updateConfirmPassword,
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Switch.adaptive(
                        value: state.rememberMe,
                        activeColor: AppColors.accentCyan,
                        onChanged: isSignIn
                            ? (_) => context.read<AuthCubit>().toggleRememberMe()
                            : null,
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (isSignIn)
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => ForgotPasswordPage(
                                cubit: context.read<ForgotPasswordCubit>(),
                              ),
                            ),
                          ),
                          child: const Text(
                            'FORGOT PASSWORD?',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.gradientBlueTop, AppColors.primaryBlue],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (isSignIn) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(builder: (_) => const ClinicShellPage()),
                            );
                            return;
                          }
                          context.read<AuthCubit>().autofill();
                        },
                        child: state.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isSignIn ? 'SIGN IN' : 'SIGN UP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text('or continue with',
                            style: TextStyle(color: Color(0xFF9CA3AF))),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        icon: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
                        onTap: () {},
                      ),
                      SocialButton(
                        icon: const Text('G',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFEA4335),
                                fontSize: 26)),
                        onTap: () {},
                      ),
                      SocialButton(
                        icon: const Icon(Icons.apple, size: 28),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          isSignIn
                              ? "Don't have an account? "
                              : 'Already have an account? ',
                          style: const TextStyle(color: Color(0xFF9CA3AF)),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<AuthCubit>()
                              .switchMode(isSignIn ? AuthMode.signUp : AuthMode.signIn),
                          child: Text(
                            isSignIn ? 'SIGN UP' : 'SIGN IN',
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label, {this.isRequired = false});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
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
