import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/repositories/authentication_repository.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final AuthenticationRepository _authenticationRepository;

  // Controllers for text fields
  TextEditingController emailController;
  TextEditingController passwordController;

  // Error messages for validation
  String? emailError;
  String? passwordError;

  // Visibility toggle for password
  bool isPasswordVisible = false;

  LoginViewModel({
    required NavigationService navigationService,
    required AuthenticationRepository authenticationRepository,
  })  : _navigationService = navigationService,
        _authenticationRepository = authenticationRepository {
    // Initialize controllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // Toggle the visibility of the password
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  // Set email and validate it
  void setEmail(String email) {
    emailController.text = email;
    emailError = _validateEmail(email);
    notifyListeners();
  }

  // Set password and validate it
  void setPassword(String password) {
    passwordController.text = password;
    passwordError = _validatePassword(password);
    notifyListeners();
  }

  // Validate email format
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    // Basic email format validation
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Handle login logic
  Future<void> login() async {
    if (emailError != null || passwordError != null) {
      // Return early if there are validation errors
      return;
    }

    setBusy(true);
    try {
      // Attempt login using the repository
      bool isSuccess = await _authenticationRepository.authenticate(
        emailController.text,
        passwordController.text,
      );

      if (isSuccess) {
        await _navigationService.navigateTo('/studyPlan');
      } else {
        // Handle failed authentication
        // TODO: Show error message to the user
      }
    } catch (e) {
      // Handle unexpected errors
      // TODO: Log error and show user-friendly message
    } finally {
      setBusy(false);
    }
  }

  // Placeholder for forgot password functionality
  void forgotPassword() {
    // TODO: Implement forgot password logic
  }

  // Placeholder for login with Google functionality
  void loginWithGoogle() {
    // TODO: Implement Google login logic
  }

  // Placeholder for login with Apple functionality
  void loginWithApple() {
    // TODO: Implement Apple login logic
  }

  // Navigate to sign-up view
  void navigateToSignUp() {
    _navigationService.navigateTo('/signUp');
  }

  @override
  void dispose() {
    // Dispose controllers to release resources
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
