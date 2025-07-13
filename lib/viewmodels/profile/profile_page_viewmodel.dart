import 'package:flutter/material.dart';
import 'package:mzala/core/initializer.dart';
import 'package:mzala/core/models/realm/authentication/realm_login_response.dart';
import 'package:mzala/services/realm/realm_service.dart';
import 'package:mzala/viewmodels/base_viewmodel.dart';

class ProfilePageViewModel extends BaseViewModel {
  final realmService = getService<RealmService>();
  late RealmLoginResponse? userData;

  // Editable profile data
  String _email = 'sophia.bennett@email.com';
  String _phoneNumber = '+1 (555) 123-4567';
  String _location = 'New York, NY';
  String _contact1 = 'David Bennett';
  String _contact2 = 'Emily Carter';
  String _contact3 = 'Michael Clark';

  // Getters for the editable data
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get location => _location;
  String get contact1 => _contact1;
  String get contact2 => _contact2;
  String get contact3 => _contact3;

  ProfilePageViewModel() {
    getUserData();
  }

  void getUserData() {
    userData = realmService.getCurrentUserData();
    // If userData contains profile info, update the local variables
    // _email = userData?.email ?? _email;
    // _phoneNumber = userData?.phoneNumber ?? _phoneNumber;
    // etc.
  }

  // Method to update email
  void updateEmail(String newEmail) {
    if (newEmail.trim().isNotEmpty && newEmail != _email) {
      _email = newEmail.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to update phone number
  void updatePhoneNumber(String newPhoneNumber) {
    if (newPhoneNumber.trim().isNotEmpty && newPhoneNumber != _phoneNumber) {
      _phoneNumber = newPhoneNumber.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to update location
  void updateLocation(String newLocation) {
    if (newLocation.trim().isNotEmpty && newLocation != _location) {
      _location = newLocation.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to update contact 1
  void updateContact1(String newContact) {
    if (newContact.trim().isNotEmpty && newContact != _contact1) {
      _contact1 = newContact.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to update contact 2
  void updateContact2(String newContact) {
    if (newContact.trim().isNotEmpty && newContact != _contact2) {
      _contact2 = newContact.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to update contact 3
  void updateContact3(String newContact) {
    if (newContact.trim().isNotEmpty && newContact != _contact3) {
      _contact3 = newContact.trim();
      notifyListeners();
      _saveProfileData();
    }
  }

  // Method to show password change dialog (keeping this as a dialog since it's more complex)
  Future<void> showPasswordChangeDialog(BuildContext context) async {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Change Password'),
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text &&
                    newPasswordController.text.isNotEmpty) {
                  _changePassword(currentPasswordController.text, newPasswordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match or are empty')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Private method to save profile data
  void _saveProfileData() {
    setBusy(true);
    // Here you would typically call an API to save the profile data
    // For now, we'll just simulate a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setBusy(false);
      // You could also show a success message here
    });
  }

  // Private method to change password
  void _changePassword(String currentPassword, String newPassword) {
    setBusy(true);
    // Here you would typically call an API to change the password
    // For now, we'll just simulate a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setBusy(false);
    });
  }
}
