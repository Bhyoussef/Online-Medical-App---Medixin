import '../../domain/entities/onboarding_slide.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/onboarding_slide_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingSlide>> getSlides() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    const mockSlides = [
      {
        'id': 1,
        'title': 'Book Consultation\nFor Your Better\nSolution',
        'description':
            'Our team will help you find the best consultation for your case.',
        'imageUrl':
            'https://images.unsplash.com/photo-1594824475317-9d1f6be6a1d2?auto=format&fit=crop&w=700&q=80',
        'ctaText': 'NEXT',
      },
      {
        'id': 2,
        'title': 'Chat Call And Live\nTalk With Your Doctor',
        'description':
            'Easily connect with doctors and start live talk for better treatment.',
        'imageUrl':
            'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=700&q=80',
        'ctaText': 'NEXT',
      },
      {
        'id': 3,
        'title': 'Book Consultation\nYour Favourite\nDoctor',
        'description':
            'Book an appointment with your favourite doctor and get better solution.',
        'imageUrl':
            'https://images.unsplash.com/photo-1612277795421-9bc7706a4a41?auto=format&fit=crop&w=700&q=80',
        'ctaText': 'START',
      },
    ];

    return mockSlides.map(OnboardingSlideModel.fromMap).toList();
  }
}
