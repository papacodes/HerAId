import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:mzala/services/interfaces/i_permissions_service.dart';
import 'package:mzala/core/initializer.dart';

class EmergencyContact {
  final String id;
  final String name;
  final String avatarUrl;
  final LatLng location;
  final String phoneNumber;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.location,
    required this.phoneNumber,
  });
}

class LocationViewModel extends BaseViewModel {
  final IPermissionsService _permissionsService = getService<IPermissionsService>();

  MapController? _mapController;
  MapController? get mapController => _mapController;

  // Current user location
  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;

  // Permission status
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  PermissionStatus get permissionStatus => _permissionStatus;

  // Emergency contacts with their locations
  final List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(
      id: '1',
      name: 'David Bennett',
      avatarUrl: 'https://via.placeholder.com/50',
      location: const LatLng(40.7128, -74.0060), // New York
      phoneNumber: '+1 (555) 123-4567',
    ),
    EmergencyContact(
      id: '2',
      name: 'Emily Carter',
      avatarUrl: 'https://via.placeholder.com/50',
      location: const LatLng(40.7589, -73.9851), // Times Square
      phoneNumber: '+1 (555) 987-6543',
    ),
    EmergencyContact(
      id: '3',
      name: 'Michael Clark',
      avatarUrl: 'https://via.placeholder.com/50',
      location: const LatLng(40.7505, -73.9934), // Near Central Park
      phoneNumber: '+1 (555) 456-7890',
    ),
  ];

  List<EmergencyContact> get emergencyContacts => _emergencyContacts;

  // Markers for flutter_map
  List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  // Card overlay state
  bool _cardsVisible = true;
  bool get cardsVisible => _cardsVisible;

  double _cardOffset = 0.0;
  double get cardOffset => _cardOffset;

  // Selected contact
  EmergencyContact? _selectedContact;
  EmergencyContact? get selectedContact => _selectedContact;

  // Track initialization states
  bool _markersAdded = false;
  bool _locationReady = false;
  bool _mapReady = false;

  LocationViewModel() {
    _initializeMap();
  }

  void _initializeMap() {
    _mapController = MapController();
    print('MapController initialized');
    _mapReady = true;
    _checkPermissionsAndGetLocation();
  }

  // Check permissions and get location
  Future<void> _checkPermissionsAndGetLocation() async {
    setBusy(true);

    try {
      _permissionStatus = await _permissionsService.getLocationPermissionStatus();
      notifyListeners();

      switch (_permissionStatus) {
        case PermissionStatus.granted:
          await _getCurrentLocation();
          break;
        case PermissionStatus.denied:
          await _requestLocationPermission();
          break;
        case PermissionStatus.deniedForever:
          print('Location permission denied forever. User needs to enable it in settings.');
          _useDefaultLocation();
          break;
        case PermissionStatus.serviceDisabled:
          print('Location services are disabled.');
          _useDefaultLocation();
          break;
      }
    } catch (e) {
      print('Error checking permissions: $e');
      _useDefaultLocation();
    }
  }

  // Request location permission
  Future<void> requestLocationPermission() async {
    await _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    try {
      LocationPermission permission = await _permissionsService.requestLocationPermission();
      _permissionStatus = await _permissionsService.getLocationPermissionStatus();
      notifyListeners();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        await _getCurrentLocation();
      } else if (permission == LocationPermission.deniedForever) {
        print('Permission denied forever. Opening app settings.');
        _useDefaultLocation();
      } else {
        print('Permission denied.');
        _useDefaultLocation();
      }
    } catch (e) {
      print('Error requesting permission: $e');
      _useDefaultLocation();
    }
  }

  // Open app settings
  Future<void> openAppSettings() async {
    await _permissionsService.openAppSettings();
  }

  void _useDefaultLocation() {
    _currentLocation = const LatLng(40.7128, -74.0060); // Default to New York
    _locationReady = true;
    _checkIfFullyInitialized();
  }

  // Call this method when the map is ready
  Future<void> onMapReady() async {
    print('onMapReady called - Map is ready');
    _mapReady = true;

    // Wait a bit for the map to be fully ready
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_markersAdded) {
      try {
        await _addEmergencyContactMarkers();
        _markersAdded = true;
        print('Markers added successfully');
      } catch (e) {
        print('Error adding markers: $e');
      }
    }

    _checkIfFullyInitialized();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentLocation = LatLng(position.latitude, position.longitude);
      _locationReady = true;
      print('Location ready: ${_currentLocation}');

      _checkIfFullyInitialized();
    } catch (e) {
      print('Error getting location: $e');
      _useDefaultLocation();
    }
  }

  void _checkIfFullyInitialized() {
    print('Checking initialization: location=$_locationReady, map=$_mapReady');
    if (_locationReady && _mapReady) {
      print('Both location and map are ready, stopping loader');
      setBusy(false);
    }
  }

  Future<void> _addEmergencyContactMarkers() async {
    print('Starting to add ${_emergencyContacts.length} markers');

    _markers.clear();

    // Add current location marker
    if (_currentLocation != null) {
      _markers.add(
        Marker(
          point: _currentLocation!,
          width: 48,
          height: 48,
          child: const Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }

    // Add emergency contact markers
    for (int i = 0; i < _emergencyContacts.length; i++) {
      final contact = _emergencyContacts[i];
      _markers.add(
        Marker(
          point: contact.location,
          width: 60,
          height: 60,
          child: GestureDetector(
            onTap: () => selectContact(contact),
            child: _buildContactMarker(contact),
          ),
        ),
      );
      print('Added marker ${i + 1}/${_emergencyContacts.length} for ${contact.name}');
    }

    notifyListeners();
  }

  Widget _buildContactMarker(EmergencyContact contact) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          contact.avatarUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  contact.name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void selectContact(EmergencyContact contact) {
    _selectedContact = contact;
    notifyListeners();

    // Animate to contact location
    _mapController?.move(contact.location, 15.0);
  }

  void updateCardOffset(double offset) {
    _cardOffset = offset;

    // If dragged down significantly, hide cards
    if (offset > 100) {
      _cardsVisible = false;
    } else if (offset < -50) {
      _cardsVisible = true;
    }

    notifyListeners();
  }

  void toggleCardsVisibility() {
    _cardsVisible = !_cardsVisible;
    _cardOffset = 0.0;
    notifyListeners();
  }

  void showAllContacts() {
    _cardsVisible = true;
    _cardOffset = 0.0;
    _selectedContact = null;
    notifyListeners();

    // Fit all markers in view
    if (_emergencyContacts.isNotEmpty && _mapController != null) {
      final bounds = _calculateBounds();
      _mapController!.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(50),
        ),
      );
    }
  }

  LatLngBounds _calculateBounds() {
    double minLat = _emergencyContacts.first.location.latitude;
    double maxLat = _emergencyContacts.first.location.latitude;
    double minLng = _emergencyContacts.first.location.longitude;
    double maxLng = _emergencyContacts.first.location.longitude;

    for (var contact in _emergencyContacts) {
      minLat = minLat < contact.location.latitude ? minLat : contact.location.latitude;
      maxLat = maxLat > contact.location.latitude ? maxLat : contact.location.latitude;
      minLng = minLng < contact.location.longitude ? minLng : contact.location.longitude;
      maxLng = maxLng > contact.location.longitude ? maxLng : contact.location.longitude;
    }

    // Include current location in bounds if available
    if (_currentLocation != null) {
      minLat = minLat < _currentLocation!.latitude ? minLat : _currentLocation!.latitude;
      maxLat = maxLat > _currentLocation!.latitude ? maxLat : _currentLocation!.latitude;
      minLng = minLng < _currentLocation!.longitude ? minLng : _currentLocation!.longitude;
      maxLng = maxLng > _currentLocation!.longitude ? maxLng : _currentLocation!.longitude;
    }

    return LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
