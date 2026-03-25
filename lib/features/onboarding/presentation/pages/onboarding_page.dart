import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/app_logo.dart';
import '../widgets/doctor_image_view.dart';
import '../widgets/onboarding_bottom_panel.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().loadSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return switch (state) {
              OnboardingInitial() || OnboardingLoading() => const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryBlue),
                ),
              OnboardingError(:final message) => _ErrorView(message: message),
              OnboardingLoaded() => Column(
                  children: [
                    const SizedBox(height: 12),
                    const AppLogo(isBlueBackground: false),
                    const SizedBox(height: 18),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: DoctorImageView(
                              imageUrl: state.currentSlide.imageUrl,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: OnboardingBottomPanel(state: state),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.read<OnboardingCubit>().loadSlides(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
