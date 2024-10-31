import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.logger.dart';
import 'package:my_app/features/authentication/email_auth_repository.dart';

/// ViewModel for the EmailAuthView, responsible for handling
/// authentication logic and managing state.
class EmailAuthViewModel extends BaseViewModel {
  final log = getLogger('EmailAuthViewModel');
  final EmailAuthRepository _authRepository = locator<EmailAuthRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _errorMessage;
  bool _canSubmit = false;

  /// Error message to display in the UI
  String? get errorMessage => _errorMessage;

  /// Determines if the form can be submitted
  bool get canSubmit => _canSubmit;

  /// Handles changes in the email input field
  void onEmailChanged(String value) {
    log.i('Email changed: $value');
    _validateForm();
  }

  /// Handles changes in the password input field
  void onPasswordChanged(String value) {
    log.i('Password changed');
    _validateForm();
  }

  /// Validates the form and updates the canSubmit state
  void _validateForm() {
    _canSubmit =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  /// Attempts to authenticate the user with the given credentials
  Future<void> authenticate() async {
    log.i('Authenticating user');
    setBusy(true);
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.authenticate(
        emailController.text,
        passwordController.text,
      );
      _navigationService.navigateTo(/* next route */);
    } catch (e) {
      log.e('Authentication failed', e);
      _errorMessage = 'Failed to authenticate. Please check your credentials.';
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

/// Repository interface for email authentication
abstract class EmailAuthRepository {
  /// Authenticates the user with the given email and password
  /// Returns a Future that completes when the authentication is successful
  /// Throws an exception if authentication fails
  Future<void> authenticate(String email, String password);
}

/// Mock implementation of EmailAuthRepository for testing purposes
class MockEmailAuthRepository implements EmailAuthRepository {
  @override
  Future<void> authenticate(String email, String password) async {
    return Future.delayed(Duration(seconds: 2), () {
      if (email != 'test@example.com' || password != 'password') {
        throw Exception('Invalid credentials');
      }
    });
  }
}
