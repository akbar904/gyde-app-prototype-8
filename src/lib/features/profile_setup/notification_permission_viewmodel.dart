import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class NotificationPermissionViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  bool _permissionGranted = false;
  bool get permissionGranted => _permissionGranted;

  Future<void> requestNotificationPermission() async {
    setBusy(true);

    try {
      // Request notification permissions here
      _permissionGranted = true;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void navigateToHome() {
    _navigationService.navigateTo('/home');
  }

  void skipNotifications() {
    _permissionGranted = false;
    notifyListeners();
    navigateToHome();
  }

  Future<void> completeSetup() async {
    if (_permissionGranted) {
      navigateToHome();
    } else {
      await requestNotificationPermission();
    }
  }
}
