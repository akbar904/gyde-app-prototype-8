import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class PhoneVerificationViewModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();
  String phoneNumber = '';
  String verificationCode = '';
  bool isVerifying = false;
  bool hasError = false;
  String errorMessage = '';
  String countryCode = '+1';

  void setPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void setVerificationCode(String value) {
    verificationCode = value;
    notifyListeners();
  }

  void setCountryCode(String value) {
    countryCode = value;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber() async {
    try {
      isVerifying = true;
      notifyListeners();

      // Mock verification delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual phone verification

      isVerifying = false;
      notifyListeners();

      // Navigate to email collection after verification
      _navigationService.navigateToEmailCollectionView();
    } catch (e) {
      isVerifying = false;
      hasError = true;
      errorMessage = 'Failed to verify phone number';
      notifyListeners();
    }
  }

  Future<void> resendVerificationCode() async {
    try {
      isVerifying = true;
      notifyListeners();

      // Mock resend delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual resend logic

      isVerifying = false;
      notifyListeners();
    } catch (e) {
      isVerifying = false;
      hasError = true;
      errorMessage = 'Failed to resend code';
      notifyListeners();
    }
  }

  void clearError() {
    hasError = false;
    errorMessage = '';
    notifyListeners();
  }
}
