import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/main/settings_viewmodel.dart';
import '../../viewmodels/view_model_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SettingsViewModel>(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (context, viewModel, child) {
        return Consumer<SettingsViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Account Section
                    _buildSectionTitle('Account'),
                    const SizedBox(height: 16),
                    _buildSettingsCard([
                      _buildSettingsItem('Profile', () => viewModel.navigateToProfile(context)),
                      _buildDivider(),
                      _buildSettingsItem('Security', () => viewModel.navigateToSecurity(context)),
                      _buildDivider(),
                      _buildSettingsItem('Notifications', () => viewModel.navigateToNotifications(context)),
                    ]),
                    const SizedBox(height: 30),

                    // Privacy Section
                    _buildSectionTitle('Privacy'),
                    const SizedBox(height: 16),
                    _buildSettingsCard([
                      _buildSettingsItem('Location Sharing', () => viewModel.navigateToLocationSharing(context)),
                      _buildDivider(),
                      _buildSettingsItem('Data Usage', () => viewModel.navigateToDataUsage(context)),
                    ]),
                    const SizedBox(height: 30),

                    // Subscription Section
                    _buildSectionTitle('Subscription'),
                    const SizedBox(height: 16),
                    _buildSettingsCard([
                      _buildSettingsItem('Manage Subscription', () => viewModel.navigateToManageSubscription(context)),
                      _buildDivider(),
                      _buildSettingsItem('Subscription Details', () => viewModel.navigateToSubscriptionDetails(context)),
                    ]),
                    const SizedBox(height: 30),

                    // Support Section
                    _buildSectionTitle('Support'),
                    const SizedBox(height: 16),
                    _buildSettingsCard([
                      _buildSettingsItem('Help Center', () => viewModel.navigateToHelpCenter(context)),
                      _buildDivider(),
                      _buildSettingsItem('Contact Us', () => viewModel.navigateToContactUs(context)),
                      _buildDivider(),
                      _buildSettingsItem('FAQs', () => viewModel.navigateToFAQs(context)),
                    ]),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        color: Colors.grey[200],
      ),
    );
  }
}
