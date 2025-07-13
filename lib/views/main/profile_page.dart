import 'package:flutter/material.dart';
import 'package:mzala/viewmodels/profile/profile_page_viewmodel.dart';
import 'package:mzala/viewmodels/view_model_provider.dart';
import 'components/profile_header.dart';
import 'components/section_title.dart';
import 'components/info_card.dart';
import 'components/info_row.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfilePageViewModel>(
      viewModelBuilder: () => ProfilePageViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: viewModel.busy
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Header
                      const ProfileHeader(
                        name: 'Sophia Bennett',
                        joinDate: 'Joined 2022',
                      ),
                      const SizedBox(height: 40),

                      // Personal Information Section
                      const SectionTitle(title: 'Personal Information'),
                      const SizedBox(height: 16),
                      InfoCard(
                        children: [
                          InfoRow(
                            label: 'Email',
                            value: viewModel.email,
                            onSave: viewModel.updateEmail,
                          ),
                          const SizedBox(height: 20),
                          InfoRow(
                            label: 'Phone Number',
                            value: viewModel.phoneNumber,
                            onSave: viewModel.updatePhoneNumber,
                          ),
                          const SizedBox(height: 20),
                          InfoRow(
                            label: 'Location',
                            value: viewModel.location,
                            onSave: viewModel.updateLocation,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Emergency Contacts Section
                      const SectionTitle(title: 'Emergency Contacts'),
                      const SizedBox(height: 16),
                      InfoCard(
                        children: [
                          InfoRow(
                            label: 'Contact 1',
                            value: viewModel.contact1,
                            onSave: viewModel.updateContact1,
                          ),
                          const SizedBox(height: 20),
                          InfoRow(
                            label: 'Contact 2',
                            value: viewModel.contact2,
                            onSave: viewModel.updateContact2,
                          ),
                          const SizedBox(height: 20),
                          InfoRow(
                            label: 'Contact 3',
                            value: viewModel.contact3,
                            onSave: viewModel.updateContact3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Security Section
                      const SectionTitle(title: 'Security'),
                      const SizedBox(height: 16),
                      InfoCard(
                        children: [
                          InfoRow(
                            label: 'Change Password',
                            value: '••••••••',
                            isEditable: false,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => viewModel.showPasswordChangeDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Change Password'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
