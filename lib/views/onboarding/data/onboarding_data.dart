import 'package:mzala/core/constants/app_images.dart';
import 'package:mzala/core/constants/general_constants.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Welcome to ${GeneralConstants.appName} App',
      description: 'Designed to help combat Gender Based Violence using modern technology.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Add Your Emergency Contacts',
      description: '${GeneralConstants.appName} allows you to add emergency contacts incase of an emergency.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Live Location Tracking',
      description: 'This platform allows you to share your location with your emergency contacts.',
    ),
  ];
}
