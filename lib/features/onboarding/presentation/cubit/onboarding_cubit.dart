import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_onboarding_slides_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._getOnboardingSlidesUseCase)
      : super(const OnboardingInitial());

  final GetOnboardingSlidesUseCase _getOnboardingSlidesUseCase;

  Future<void> loadSlides() async {
    emit(const OnboardingLoading());
    try {
      final slides = await _getOnboardingSlidesUseCase();
      if (slides.isEmpty) {
        emit(const OnboardingError('No onboarding slides found.'));
        return;
      }
      emit(OnboardingLoaded(slides: slides, currentIndex: 0));
    } catch (_) {
      emit(const OnboardingError('Something went wrong. Please try again.'));
    }
  }

  void next() {
    final currentState = state;
    if (currentState is! OnboardingLoaded) {
      return;
    }

    final nextIndex = currentState.currentIndex + 1;
    if (nextIndex >= currentState.slides.length) {
      return;
    }

    emit(currentState.copyWith(currentIndex: nextIndex));
  }

  void back() {
    final currentState = state;
    if (currentState is! OnboardingLoaded || currentState.currentIndex == 0) {
      return;
    }

    emit(currentState.copyWith(currentIndex: currentState.currentIndex - 1));
  }

  void skipToEnd() {
    final currentState = state;
    if (currentState is! OnboardingLoaded) {
      return;
    }

    emit(currentState.copyWith(currentIndex: currentState.slides.length - 1));
  }
}
