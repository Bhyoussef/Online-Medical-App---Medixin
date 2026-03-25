import '../../domain/entities/onboarding_slide.dart';

class OnboardingSlideModel extends OnboardingSlide {
  const OnboardingSlideModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.ctaText,
  });

  factory OnboardingSlideModel.fromMap(Map<String, dynamic> map) {
    return OnboardingSlideModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      ctaText: map['ctaText'] as String,
    );
  }
}
