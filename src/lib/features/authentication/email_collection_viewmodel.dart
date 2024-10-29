import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EmailCollectionViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  final emailController = TextEditingController();
  String? emailError;

  bool get isFormValid => emailError == null && emailController.text.isNotEmpty;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Email is required';
      notifyListeners();
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      emailError = 'Please enter a valid email';
      notifyListeners();
      return;
    }

    emailError = null;
    notifyListeners();
  }

  void onEmailSubmit() {
    if (!isFormValid) return;

    setBusy(true);
    try {
      // TODO: Implement email submission logic
      _navigationService.navigateToTermsView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
