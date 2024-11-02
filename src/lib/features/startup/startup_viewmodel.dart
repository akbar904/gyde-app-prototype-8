
// lib/features/startup/startup_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/authentication/authentication_repository.dart';

class StartupViewModel extends BaseViewModel {
	final TextEditingController emailController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	final AuthenticationRepository _authenticationRepository;

	// Indicates loading state during startup
	bool _isLoading = false;
	bool get isLoading => _isLoading;

	StartupViewModel(this._authenticationRepository);

	/// Handles user startup logic.
	/// Validates email and password, updates loading state, 
	/// and calls the authentication repository.
	Future<void> startup() async {
		if (_validateInputs()) {
			_setLoading(true);
			try {
				await _authenticationRepository.login(
					email: emailController.text,
					password: passwordController.text,
				);
				// Handle successful startup (e.g., navigate to another screen)
			} catch (e) {
				// Handle error (e.g., show an error message)
			} finally {
				_setLoading(false);
			}
		}
	}

	/// Validates email and password inputs.
	bool _validateInputs() {
		if (!_validateEmail(emailController.text)) {
			// Show an error message for invalid email
			return false;
		}
		if (passwordController.text.isEmpty) {
			// Show an error message for empty password
			return false;
		}
		return true;
	}

	/// Validates email format.
	bool _validateEmail(String email) {
		// Simple regex for email validation
		final RegExp emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
		return emailRegEx.hasMatch(email);
	}

	/// Sets the loading state.
	void _setLoading(bool value) {
		_isLoading = value;
		notifyListeners();
	}

	/// Disposes of controllers to free up resources.
	@override
	void dispose() {
		emailController.dispose();
		passwordController.dispose();
		super.dispose();
	}
}
