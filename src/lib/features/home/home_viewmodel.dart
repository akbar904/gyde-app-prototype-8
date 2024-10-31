import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/services/navigation_service.dart';
import 'package:my_app/services/dialog_service.dart';
import 'package:my_app/models/failure.dart';

/// Handles the logic for the [LoginView] and manages its state.
class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _hasError = false;

  /// Constructor with dependency injection.
  LoginViewModel({
    required AuthenticationService authenticationService,
    required NavigationService navigationService,
    required DialogService dialogService,
  })  : _authenticationService = authenticationService,
        _navigationService = navigationService,
        _dialogService = dialogService;

  /// Sets the email for authentication.
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  /// Sets the password for authentication.
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;
  bool get hasError => _hasError;

  /// Initiates the login process.
  ///
  /// Validates input and handles any errors that occur during login.
  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _setError('Email and password cannot be empty.');
      return;
    }

    setBusy(true);
    _setError('');

    try {
      await _authenticationService.login(email: _email, password: _password);
      _navigationService.navigateTo('/home');
    } on Failure catch (e) {
      _setError(e.message);
      _dialogService.showDialog(
        title: 'Login Failed',
        description: e.message,
      );
    } finally {
      setBusy(false);
    }
  }

  /// Sets the error message and updates the error state.
  void _setError(String message) {
    _errorMessage = message;
    _hasError = message.isNotEmpty;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    // Perform any cleanup operations if needed.
    super.dispose();
  }
}

/// Abstract interface for authentication.
abstract class AuthenticationService {
  Future<void> login({required String email, required String password});
}

/// Mock implementation of [AuthenticationService] for testing purposes.
class MockAuthenticationService implements AuthenticationService {
  @override
  Future<void> login({required String email, required String password}) async {
    return Future.delayed(Duration(seconds: 1), () {
      if (email != "test@example.com" || password != "password123") {
        throw Failure('Invalid email or password.');
      }
    });
  }
}

/// Defines a failure with a message.
class Failure implements Exception {
  final String message;
  Failure(this.message);
}
