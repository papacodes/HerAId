import 'package:flutter/material.dart';
import 'package:mzala/views/main/settings_page.dart';
import 'components/quick_action_card.dart';
import 'components/location_card.dart';
import 'components/sos_button.dart';
import 'components/sos_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Chomie',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 100, // Add bottom padding to avoid overlap with SOS button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                // Emergency Contacts Card
                QuickActionCard(
                  title: 'Emergency Contacts',
                  subtitle: 'Manage your emergency contacts',
                  icon: Icons.people_rounded,
                  iconColor: Colors.brown,
                  onTap: () {
                    // Handle emergency contacts navigation
                  },
                ),

                const SizedBox(height: 16),

                // Current Location Card (special design)
                LocationCard(
                  title: 'Your Current Location',
                  subtitle: 'View and share your location',
                  onTap: () {
                    // Handle location navigation
                  },
                ),

                const SizedBox(height: 16),

                // AI Chatbot Card
                QuickActionCard(
                  title: 'AI Chatbot',
                  subtitle: 'Get help and support',
                  icon: Icons.rocket_launch,
                  iconColor: Colors.blue,
                  onTap: () {
                    // Handle AI chatbot navigation
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // Persistent SOS Button at bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SOSButton(
                onPressed: () => SOSDialog.show(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
