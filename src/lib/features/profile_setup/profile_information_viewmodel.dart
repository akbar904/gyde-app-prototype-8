import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class ProfileInformationViewModel extends BaseViewModel {
  String _firstName = '';
  String _lastName = '';
  String _companyName = '';
  bool _isBusinessMode = false;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get companyName => _companyName;
  bool get isBusinessMode => _isBusinessMode;

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setCompanyName(String value) {
    _companyName = value;
    notifyListeners();
  }

  void setIsBusinessMode(bool value) {
    _isBusinessMode = value;
    notifyListeners();
  }

  bool validateProfileInformation() {
    if (_firstName.isEmpty || _lastName.isEmpty) {
      return false;
    }
    if (_isBusinessMode && _companyName.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> submitProfileInformation() async {
    if (!validateProfileInformation()) {
      throw Exception('Invalid profile information');
    }
    // Code to submit the profile information to the server or local storage
    // This could involve calling an API or saving data locally
    // await apiService.submitProfileData({...});
  }
}
