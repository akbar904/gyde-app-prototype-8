
// lib/features/home/home_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/auth_repository.dart';

/// ViewModel for the HomeView, managing home-related logic and state.
class HomeViewModel extends BaseViewModel {
	final AuthRepository _authRepository;

	String _email;
	String _password;
	String _errorMessage;

	/// Constructor that requires an instance of [AuthRepository].
	HomeViewModel(this._authRepository) 
		: _email = '', 
		  _password = '', 
		  _errorMessage = '';

	/// Returns the current email.
	String get email => _email;

	/// Returns the current password.
	String get password => _password;

	/// Returns the current error message, if any.
	String get errorMessage => _errorMessage;

	/// Sets the email and notifies listeners.
	void setEmail(String email) {
		_email = email;
		notifyListeners();
	}

	/// Sets the password and notifies listeners.
	void setPassword(String password) {
		_password = password;
		notifyListeners();
	}

	/// Validates email format.
	bool _isEmailValid(String email) {
		final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
		return emailRegex.hasMatch(email);
	}

	/// Validates password length.
	bool _isPasswordValid(String password) {
		return password.isNotEmpty && password.length >= 6;
	}

	/// Handles user login with email and password.
	Future<void> login() async {
		setBusy(true);
		_errorMessage = ''; // Reset error message
		try {
			if (!_isEmailValid(_email)) {
				_errorMessage = 'Invalid email format.';
				notifyListeners();
				return;
			}

			if (!_isPasswordValid(_password)) {
				_errorMessage = 'Password must be at least 6 characters.';
				notifyListeners();
				return;
			}

			await _authRepository.login(_email, _password);
			// Navigate to Study Plan
		} catch (e) {
			_errorMessage = 'Login failed. Please try again.';
		} finally {
			setBusy(false);
		}
	}

	/// Handles Google sign-in.
	Future<void> signInWithGoogle() async {
		setBusy(true);
		_errorMessage = ''; // Reset error message
		try {
			await _authRepository.signInWithGoogle();
			// Navigate to Study Plan
		} catch (e) {
			_errorMessage = 'Google sign-in failed. Please try again.';
		} finally {
			setBusy(false);
		}
	}

	/// Handles Apple sign-in.
	Future<void> signInWithApple() async {
		setBusy(true);
		_errorMessage = ''; // Reset error message
		try {
			await _authRepository.signInWithApple();
			// Navigate to Study Plan
		} catch (e) {
			_errorMessage = 'Apple sign-in failed. Please try again.';
		} finally {
			setBusy(false);
		}
	}
}
