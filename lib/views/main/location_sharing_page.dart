import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/main/location_sharing_viewmodel.dart';
import 'components/section_title.dart';
import 'components/settings_card.dart';

class LocationSharingPage extends StatelessWidget {
  const LocationSharingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationSharingViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Location Sharing',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: viewModel.refreshLocationStatus,
            ),
          ],
        ),
        body: viewModel.busy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Device Location Section
                    const SectionTitle(title: 'Device Location'),
                    const SizedBox(height: 8),
                    Text(
                      'Control your device\'s location services and permissions.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        _buildLocationToggle(
                          context,
                          viewModel,
                          'Location Services',
                          'Enable location services on this device',
                          viewModel.deviceLocationEnabled,
                          viewModel.toggleDeviceLocation,
                          enabled: viewModel.locationServiceEnabled,
                        ),
                        if (!viewModel.locationServiceEnabled)
                          _buildLocationStatusCard(
                            context,
                            'Location services are disabled',
                            'Enable location services in your device settings to use location features.',
                            Icons.location_off,
                            Colors.orange,
                            'Open Settings',
                            viewModel.openAppSettings,
                          ),
                        if (!viewModel.hasLocationPermission && viewModel.locationServiceEnabled)
                          _buildLocationStatusCard(
                            context,
                            'Location permission required',
                            'Grant location permission to enable location sharing features.',
                            Icons.location_disabled,
                            Colors.red,
                            'Grant Permission',
                            () => viewModel.toggleDeviceLocation(true),
                          ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // App Location Settings Section
                    const SectionTitle(title: 'App Location Settings'),
                    const SizedBox(height: 8),
                    Text(
                      'Configure how the app uses your location data.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SettingsCard(
                      children: [
                        _buildLocationToggle(
                          context,
                          viewModel,
                          'Share with Emergency Contacts',
                          'Allow emergency contacts to see your location',
                          viewModel.shareWithEmergencyContacts,
                          viewModel.toggleShareWithEmergencyContacts,
                          enabled: viewModel.deviceLocationEnabled,
                        ),
                        const Divider(height: 1),
                        _buildLocationToggle(
                          context,
                          viewModel,
                          'Location Tracking',
                          'Allow the app to track your location for safety features',
                          viewModel.allowLocationTracking,
                          viewModel.toggleAllowLocationTracking,
                          enabled: viewModel.deviceLocationEnabled,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Information Section
                    const SectionTitle(title: 'Information'),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Privacy & Security',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your location data is encrypted and only shared with your designated emergency contacts when enabled. You can disable location sharing at any time.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
      viewModelBuilder: () => LocationSharingViewModel(),
    );
  }

  Widget _buildLocationToggle(BuildContext context, LocationSharingViewModel viewModel, String title, String subtitle,
      bool value, Function(bool) onChanged,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: enabled ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: enabled ? Colors.grey[600] : Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled ? value : false,
            onChanged: enabled ? onChanged : null,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStatusCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String buttonText,
    VoidCallback onPressed,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
