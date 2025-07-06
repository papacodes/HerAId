import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../base_viewmodel.dart';
import '../../views/main/home_page.dart';
import '../../views/main/location_page.dart';
import '../../views/main/chat_page.dart';
import '../../views/main/profile_page.dart';
import '../../views/main/settings_page.dart';

class DashboardViewModel extends BaseViewModel {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  DashboardViewModel();

  // Navigation bar items - reverted to 3 tabs
  final List<SalomonBottomBarItem> navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: const Color(0xFF81C784),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.map),
      title: const Text("Map"),
      selectedColor: const Color(0xFF42A5F5),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.build),
      title: const Text("AI Tools"),
      selectedColor: const Color(0xFFFF7043),
    ),
  ];

  // Get current page widget based on selected index - updated for 3 tabs
  Widget get currentPage {
    switch (_selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const LocationPage();
      case 2:
        return const ChatPage();
      default:
        return const HomePage();
    }
  }

  // Handle bottom navigation tap
  void onBottomNavTap(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  // Get current page title - updated for 3 tabs
  String get currentPageTitle {
    switch (_selectedIndex) {
      case 0:
        return "Safety First";
      case 1:
        return "Map";
      case 2:
        return "AI Tools";
      default:
        return "HerAId";
    }
  }

  // Navigation methods
  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void navigateToSettings(BuildContext context) {
    // Settings now navigates using Navigator.push instead of bottom nav
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  void navigateToEmergencyContacts() {
    // Handle navigation to emergency contacts
    notifyListeners();
  }

  void navigateToLocationSharing() {
    // Handle navigation to location sharing
    notifyListeners();
  }

  void navigateToAIChat() {
    // Switch to AI Tools tab (now index 2 instead of 3)
    _selectedIndex = 2;
    notifyListeners();
  }

  void sendSOSAlert() {
    // Handle SOS alert logic
    setBusy(true);
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setBusy(false);
      // Show success message or handle error
    });
  }
}
