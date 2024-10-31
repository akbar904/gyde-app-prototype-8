import 'package:stacked/stacked.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/utils/validation_helpers.dart';

/// ViewModel for the LoginView, manages authentication logic and state.
class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  String _email = '';
  String _password = '';
  String? _errorMessage;

  User? _user;

  /// Constructor with dependency injection for the authentication service.
  /// Allows for easy testing and mocking.
  LoginViewModel({required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  /// Gets the current email input by the user.
  String get email => _email;

  /// Gets the current password input by the user.
  String get password => _password;

  /// Gets the current error message, if any.
  String? get errorMessage => _errorMessage;

  /// Gets the authenticated user, if any.
  User? get user => _user;

  /// Updates the email state and validates it.
  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  /// Updates the password state.
  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  /// Attempts to login the user with the current email and password.
  /// Handles validation, error handling, and updates loading state.
  Future<void> login() async {
    if (!isInputValid()) {
      _errorMessage = 'Invalid input';
      notifyListeners();
      return;
    }

    setBusy(true);
    try {
      _user = await _authenticationService.login(
          email: _email, password: _password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  /// Validates the input fields.
  /// Returns true if both fields are valid, false otherwise.
  bool isInputValid() {
    return ValidationHelpers.isValidEmail(_email) && _password.isNotEmpty;
  }

  @override
  void dispose() {
    // Dispose resources if needed
    super.dispose();
  }
}

/// Interface for the authentication service, defining contract for login logic.
abstract class AuthenticationService {
  /// Logs in a user with the provided email and password.
  /// Returns a [User] object on success.
  /// Throws an exception on failure.
  Future<User> login({required String email, required String password});
}

/// Mock implementation of the AuthenticationService for testing.
class MockAuthenticationService implements AuthenticationService {
  @override
  Future<User> login({required String email, required String password}) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Mock user data
    if (email == 'test@example.com' && password == 'password') {
      return User(id: 1, email: email);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}

/// Utility class for validation helpers.
class ValidationHelpers {
  /// Validates if the provided email is in a correct format.
  static bool isValidEmail(String email) {
    // Basic email format validation.
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}
