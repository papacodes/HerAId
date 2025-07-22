import 'package:flutter/material.dart';
import '../base_viewmodel.dart';
import '../../views/main/profile_page.dart';
import '../../views/main/location_sharing_page.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel();

  // Navigation methods
  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void navigateToSecurity(BuildContext context) {
    // TODO: Navigate to security settings
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SecurityPage()),
    // );
  }

  void navigateToNotifications(BuildContext context) {
    // TODO: Navigate to notification settings
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const NotificationsPage()),
    // );
  }

  void navigateToLocationSharing(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSharingPage()),
    );
  }

  void navigateToDataUsage(BuildContext context) {
    // TODO: Navigate to data usage settings
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const DataUsagePage()),
    // );
  }

  void navigateToManageSubscription(BuildContext context) {
    // TODO: Navigate to subscription management
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ManageSubscriptionPage()),
    // );
  }

  void navigateToSubscriptionDetails(BuildContext context) {
    // TODO: Navigate to subscription details
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SubscriptionDetailsPage()),
    // );
  }

  void navigateToHelpCenter(BuildContext context) {
    // TODO: Navigate to help center
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HelpCenterPage()),
    // );
  }

  void navigateToContactUs(BuildContext context) {
    // TODO: Navigate to contact us
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ContactUsPage()),
    // );
  }

  void navigateToFAQs(BuildContext context) {
    // TODO: Navigate to FAQs
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const FAQsPage()),
    // );
  }
}