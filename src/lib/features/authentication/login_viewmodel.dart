import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'auth_repository.dart';

/// ViewModel for the LoginView, manages authentication logic and state.
class LoginViewModel extends BaseViewModel {
  final AuthRepository _authRepository;

  // Reactive properties for email, password, and errors
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;

  LoginViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  /// Email input for login
  String get email => _email;

  /// Password input for login
  String get password => _password;

  /// Error message for email validation
  String? get emailError => _emailError;

  /// Error message for password validation
  String? get passwordError => _passwordError;

  /// Updates the email and validates it.
  void updateEmail(String value) {
    _email = value;
    _emailError = _validateEmail(value);
    notifyListeners(); // Notify listeners for UI updates
  }

  /// Updates the password and validates it.
  void updatePassword(String value) {
    _password = value;
    _passwordError = _validatePassword(value);
    notifyListeners(); // Notify listeners for UI updates
  }

  /// Handles user login with email and password.
  Future<void> login() async {
    if (_emailError == null && _passwordError == null) {
      setBusy(true); // Set loading state
      try {
        await _authRepository.login(_email, _password);
      } catch (e) {
        // Handle login error appropriately
        _emailError =
            'Login failed. Please try again.'; // Example error handling
        notifyListeners(); // Update UI with error message
      } finally {
        setBusy(false); // Reset loading state
      }
    }
  }

  /// Handles Google sign-in.
  Future<void> signInWithGoogle() async {
    setBusy(true); // Set loading state
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      // Handle Google sign-in error
      _emailError =
          'Google sign-in failed. Please try again.'; // Example error handling
      notifyListeners(); // Update UI with error message
    } finally {
      setBusy(false); // Reset loading state
    }
  }

  /// Handles Apple sign-in.
  Future<void> signInWithApple() async {
    setBusy(true); // Set loading state
    try {
      await _authRepository.signInWithApple();
    } catch (e) {
      // Handle Apple sign-in error
      _emailError =
          'Apple sign-in failed. Please try again.'; // Example error handling
      notifyListeners(); // Update UI with error message
    } finally {
      setBusy(false); // Reset loading state
    }
  }

  /// Validates the email format.
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    // Add additional email format validation if required
    return null;
  }

  /// Validates the password.
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    // Add additional password validation if required
    return null;
  }
}
