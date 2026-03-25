import 'package:equatable/equatable.dart';

import '../../domain/entities/onboarding_slide.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

final class OnboardingLoaded extends OnboardingState {
  const OnboardingLoaded({
    required this.slides,
    required this.currentIndex,
  });

  final List<OnboardingSlide> slides;
  final int currentIndex;

  bool get isLast => currentIndex == slides.length - 1;

  OnboardingSlide get currentSlide => slides[currentIndex];

  OnboardingLoaded copyWith({
    List<OnboardingSlide>? slides,
    int? currentIndex,
  }) {
    return OnboardingLoaded(
      slides: slides ?? this.slides,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [slides, currentIndex];
}

final class OnboardingError extends OnboardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
