import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/main/settings_viewmodel.dart';
import '../../viewmodels/view_model_provider.dart';
import 'components/section_title.dart';
import 'components/settings_card.dart';
import 'components/settings_item.dart';
import 'components/settings_divider.dart';

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
                    const SectionTitle(title: 'Account'),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        SettingsItem(
                          title: 'Profile',
                          onTap: () => viewModel.navigateToProfile(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'Security',
                          onTap: () => viewModel.navigateToSecurity(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'Notifications',
                          onTap: () => viewModel.navigateToNotifications(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Privacy Section
                    const SectionTitle(title: 'Privacy'),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        SettingsItem(
                          title: 'Location Sharing',
                          onTap: () => viewModel.navigateToLocationSharing(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'Data Usage',
                          onTap: () => viewModel.navigateToDataUsage(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Subscription Section
                    const SectionTitle(title: 'Subscription'),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        SettingsItem(
                          title: 'Manage Subscription',
                          onTap: () => viewModel.navigateToManageSubscription(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'Subscription Details',
                          onTap: () => viewModel.navigateToSubscriptionDetails(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Support Section
                    const SectionTitle(title: 'Support'),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        SettingsItem(
                          title: 'Help Center',
                          onTap: () => viewModel.navigateToHelpCenter(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'Contact Us',
                          onTap: () => viewModel.navigateToContactUs(context),
                        ),
                        const SettingsDivider(),
                        SettingsItem(
                          title: 'FAQs',
                          onTap: () => viewModel.navigateToFAQs(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
