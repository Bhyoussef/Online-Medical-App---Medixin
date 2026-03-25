import '../entities/onboarding_slide.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingSlidesUseCase {
  const GetOnboardingSlidesUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<List<OnboardingSlide>> call() {
    return _repository.getSlides();
  }
}
