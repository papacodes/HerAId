import 'package:her_aid/core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Welcome to Sesi App',
      description: 'Designed to help combat Gender Based Violence using modern technology.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Add Your Emergency Contacts',
      description: 'Sesi allows you to add emergency contacts incase of an emergency.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Live Location Tracking',
      description: 'This platform allows you to share your location with your emergency contacts.',
    ),
  ];
}
