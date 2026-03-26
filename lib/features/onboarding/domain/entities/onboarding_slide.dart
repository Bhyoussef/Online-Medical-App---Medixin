import 'package:equatable/equatable.dart';

class OnboardingSlide extends Equatable {
  const OnboardingSlide({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ctaText,
  });

  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String ctaText;

  @override
  List<Object?> get props => [id, title, description, imageUrl, ctaText];
}
