import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

/// Repository interface for user data management
abstract class IUserRepository {
  Future<void> saveUserInfo(String name, String email);
  Future<bool> validateEmail(String email);
}

/// Mock implementation of user repository
class MockUserRepository implements IUserRepository {
  @override
  Future<void> saveUserInfo(String name, String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  Future<bool> validateEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}

/// ViewModel for collecting and validating user information
class UserInfoViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final IUserRepository _userRepository;

  UserInfoViewModel({
    required NavigationService navigationService,
    required DialogService dialogService,
    IUserRepository? userRepository,
  })  : _navigationService = navigationService,
        _dialogService = dialogService,
        _userRepository = userRepository ?? MockUserRepository();

  String _name = '';
  String _email = '';
  bool _isFormValid = false;
  bool _isEmailValid = false;
  bool _isValidating = false;

  // Public getters
  String get name => _name;
  String get email => _email;
  bool get isFormValid => _isFormValid;
  bool get canSubmit => _isFormValid && !_isValidating && !isBusy;

  /// Updates user name and validates form
  void setName(String value) {
    _name = value.trim();
    _validateForm();
    notifyListeners();
  }

  /// Updates email and triggers validation
  Future<void> setEmail(String value) async {
    _email = value.trim();
    _isValidating = true;
    notifyListeners();

    try {
      _isEmailValid = await _userRepository.validateEmail(_email);
    } catch (e) {
      _isEmailValid = false;
      await _dialogService.showDialog(
        title: 'Validation Error',
        description: 'Failed to validate email. Please try again.',
      );
    } finally {
      _isValidating = false;
      _validateForm();
      notifyListeners();
    }
  }

  /// Validates form state
  void _validateForm() {
    _isFormValid = _name.isNotEmpty &&
        _email.isNotEmpty &&
        _isEmailValid &&
        _name.length >= 2;
  }

  /// Saves user information and navigates to next screen
  Future<void> saveUserInfo(String name, String email) async {
    if (!_isFormValid) return;

    try {
      setBusy(true);
      await _userRepository.saveUserInfo(name, email);
      await _navigationService.navigateToExamSelectionView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to save user information. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
