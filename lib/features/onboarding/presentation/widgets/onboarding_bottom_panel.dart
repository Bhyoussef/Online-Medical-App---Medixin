import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/registration_page.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import 'next_ring_button.dart';
import 'page_dots.dart';

class OnboardingBottomPanel extends StatelessWidget {
  const OnboardingBottomPanel({super.key, required this.state});

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientBlueTop, AppColors.gradientBlueBottom],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            state.currentSlide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 1.25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            state.currentSlide.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          PageDots(currentIndex: state.currentIndex, length: state.slides.length),
          const Spacer(),
          Row(
            children: [
              Opacity(
                opacity: state.currentIndex == 0 ? 0.0 : 1.0,
                child: IconButton(
                  onPressed: state.currentIndex == 0 ? null : cubit.back,
                  icon: const Icon(Icons.arrow_back, color: Colors.white70),
                ),
              ),
              Expanded(
                child: Center(
                  child: NextRingButton(
                    label: state.currentSlide.ctaText,
                    onPressed: () {
                      if (state.isLast) {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => RegistrationPage(
                              authCubit: context.read<AuthCubit>(),
                            ),
                          ),
                        );
                        return;
                      }
                      cubit.next();
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: state.isLast ? null : cubit.skipToEnd,
                child: Text(
                  state.isLast ? '' : 'SKIP',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
