import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mzala/services/interfaces/i_permissions_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mzala/viewmodels/main/location_viewmodel.dart';

class EmergencyContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final VoidCallback onTap;
  final bool isSelected;

  const EmergencyContactCard({
    required this.contact,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(contact.avatarUrl),
          backgroundColor: Colors.blue,
          child: Text(
            contact.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(contact.phoneNumber),
        trailing: Icon(
          Icons.location_on,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

class LocationPage extends StatelessWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
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
            'Emergency Contacts Location',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                viewModel.cardsVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: viewModel.toggleCardsVisibility,
            ),
            IconButton(
              icon: const Icon(Icons.my_location, color: Colors.black),
              onPressed: viewModel.showAllContacts,
            ),
          ],
        ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  // Map
                  FlutterMap(
                    mapController: viewModel.mapController,
                    options: MapOptions(
                      initialCenter: viewModel.currentLocation ?? const LatLng(40.7128, -74.0060),
                      initialZoom: 12,
                      minZoom: 3,
                      maxZoom: 19,
                      onMapReady: () {
                        print('Map is ready');
                        Future.microtask(() => viewModel.onMapReady());
                      },
                    ),
                    children: [
                      TileLayer(
                        // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //default urlTemplate
                        urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                        userAgentPackageName: 'com.adrielcorp.chomie',
                      ),
                      MarkerLayer(
                        markers: viewModel.markers,
                      ),
                    ],
                  ),
                  if (viewModel.permissionStatus != PermissionStatus.granted)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: Card(
                            margin: const EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_off,
                                    size: 64,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _getPermissionMessage(viewModel.permissionStatus),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  if (viewModel.permissionStatus == PermissionStatus.denied)
                                    ElevatedButton(
                                      onPressed: viewModel.requestLocationPermission,
                                      child: const Text('Grant Location Permission'),
                                    ),
                                  if (viewModel.permissionStatus == PermissionStatus.deniedForever)
                                    ElevatedButton(
                                      onPressed: viewModel.openAppSettings,
                                      child: const Text('Open Settings'),
                                    ),
                                  if (viewModel.permissionStatus == PermissionStatus.serviceDisabled)
                                    const Text(
                                      'Please enable location services in your device settings.',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Emergency Contact Cards Overlay
                  if (viewModel.cardsVisible)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.translationValues(
                          0,
                          viewModel.cardOffset,
                          0,
                        ),
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            viewModel.updateCardOffset(
                              viewModel.cardOffset + details.delta.dy,
                            );
                          },
                          onPanEnd: (details) {
                            // Snap to position based on velocity
                            if (details.velocity.pixelsPerSecond.dy > 500) {
                              viewModel.updateCardOffset(200); // Hide cards
                            } else if (details.velocity.pixelsPerSecond.dy < -500) {
                              viewModel.updateCardOffset(0); // Show cards
                            } else {
                              // Snap based on current position
                              if (viewModel.cardOffset > 50) {
                                viewModel.updateCardOffset(200);
                              } else {
                                viewModel.updateCardOffset(0);
                              }
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, -2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Drag Handle
                                Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),

                                // Header
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Emergency Contacts',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${viewModel.emergencyContacts.length} contacts',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Contact Cards
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 300,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemCount: viewModel.emergencyContacts.length,
                                    itemBuilder: (context, index) {
                                      final contact = viewModel.emergencyContacts[index];
                                      return EmergencyContactCard(
                                        contact: contact,
                                        isSelected: viewModel.selectedContact?.id == contact.id,
                                        onTap: () => viewModel.selectContact(contact),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Floating Action Button to show cards when hidden
                  if (!viewModel.cardsVisible)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: viewModel.toggleCardsVisibility,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
      ),
      viewModelBuilder: () => LocationViewModel(),
    );
  }
}

// Add this widget in the Stack after the map

// Add this helper method
String _getPermissionMessage(PermissionStatus status) {
  switch (status) {
    case PermissionStatus.denied:
      return 'Location access is required to show your current position and nearby emergency contacts.';
    case PermissionStatus.deniedForever:
      return 'Location permission has been permanently denied. Please enable it in app settings.';
    case PermissionStatus.serviceDisabled:
      return 'Location services are disabled. Please enable them in your device settings.';
    case PermissionStatus.granted:
      return '';
  }
}
