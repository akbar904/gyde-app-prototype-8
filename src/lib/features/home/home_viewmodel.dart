
// lib/features/home/home_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/authentication/authentication_repository.dart';

// The HomeViewModel handles the business logic for the HomeView.
// It manages user-related actions and data presentation.
class HomeViewModel extends BaseViewModel {
	final AuthenticationRepository _authenticationRepository;

	// Reactive properties for user data
	String? _userName;
	bool _isLoading = false;
	String? _errorMessage;

	// Constructor with dependency injection for the authentication repository
	HomeViewModel(this._authenticationRepository);

	// Reactive properties
	String? get userName => _userName;
	bool get isLoading => _isLoading;
	String? get errorMessage => _errorMessage;

	// Fetches user data
	Future<void> fetchUserData() async {
		_errorMessage = null; // Reset error message
		setBusy(true);
		_isLoading = true;
		notifyListeners();
		try {
			// Simulate fetching user data from the repository
			_userName = await _authenticationRepository.getUserName();
		} catch (e) {
			_errorMessage = 'Failed to fetch user data: ${e.toString()}';
		} finally {
			setBusy(false);
			_isLoading = false;
		}
		notifyListeners();
	}

	// Clean up resources when the ViewModel is disposed
	@override
	void dispose() {
		super.dispose();
	}
}

// lib/features/authentication/authentication_repository.dart
// This interface defines the contract for an AuthenticationRepository.
abstract class AuthenticationRepository {
	Future<void> login(String email, String password);
	Future<String> getUserName();
}

// lib/features/authentication/mock_authentication_repository.dart
import 'dart:async';
import 'authentication_repository.dart';

// Mock implementation of the AuthenticationRepository for testing purposes.
class MockAuthenticationRepository implements AuthenticationRepository {
	@override
	Future<void> login(String email, String password) {
		return Future.delayed(Duration(seconds: 2), () {
			if (email != 'test@example.com' || password != 'password123') {
				throw Exception('Invalid credentials');
			}
		});
	}

	@override
	Future<String> getUserName() {
		return Future.delayed(Duration(seconds: 1), () {
			return 'John Doe'; // Simulated user name
		});
	}
}
