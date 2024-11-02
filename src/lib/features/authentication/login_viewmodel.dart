// lib/features/authentication/login_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Define the AuthenticationRepository interface
abstract class IAuthenticationRepository {
  Future<void> login(String email, String password);
  Future<void> forgotPassword(String email);
}

// Mock implementation of the AuthenticationRepository for testing
class MockAuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty.');
    }
    // Simulate successful login
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    if (email.isEmpty) {
      throw Exception('Email cannot be empty.');
    }
    // Simulate successful password reset
  }
}

class LoginViewModel extends BaseViewModel {
  final IAuthenticationRepository _authenticationRepository;

  // Reactive properties
  String _email = '';
  String _password = '';
  String? _errorMessage;
  bool _isLoading = false;
  bool _showPassword = false;

  // Constructor with dependency injection
  LoginViewModel({required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  String get email => _email;
  String get password => _password;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;

  // Update email and notify listeners
  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  // Update password and notify listeners
  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  /// Handles user login logic.
  /// Throws an Exception if login fails.
  Future<void> login() async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await _authenticationRepository.login(email, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Handles forgot password logic.
  /// Throws an Exception if the email is invalid.
  Future<void> forgotPassword() async {
    if (_email.isEmpty) {
      _errorMessage = 'Please enter your email.';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await _authenticationRepository.forgotPassword(email);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
