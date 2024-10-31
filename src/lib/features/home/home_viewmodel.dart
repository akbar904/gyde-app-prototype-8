// Import necessary packages
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:com.com.walturn.aorteq_app/services/authentication_service.dart';

// Define the ViewModel for the WelcomeView
class WelcomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;

  // Constructor with dependency injection
  WelcomeViewModel({
    required AuthenticationService authenticationService,
    required NavigationService navigationService,
  })  : _authenticationService = authenticationService,
        _navigationService = navigationService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    setBusy(true);
    try {
      await _authenticationService.signInWithGoogle();
      // Navigate to the next screen upon successful authentication
      _navigationService.navigateTo('/home');
    } catch (e) {
      // Handle any errors that occur during sign in
      setError(e);
      // Show an error dialog or a snackbar
    } finally {
      setBusy(false);
    }
  }

  // Navigate to Email Authentication screen
  void navigateToEmailAuth() {
    _navigationService.navigateTo('/email-auth');
  }

  // Navigate to Sign-Up screen
  void navigateToSignUp() {
    _navigationService.navigateTo('/sign-up');
  }

  // Set busy state
  void setBusy(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set error state
  void setError(dynamic error) {
    // Implement error handling logic
  }

  // Dispose resources if necessary
  @override
  void dispose() {
    super.dispose();
  }
}

// AuthenticationService interface definition
abstract class AuthenticationService {
  Future<void> signInWithGoogle();
}

// Mock implementation of AuthenticationService
class MockAuthenticationService implements AuthenticationService {
  @override
  Future<void> signInWithGoogle() async {
    await Future.delayed(Duration(seconds: 2));
    // Simulate a sign-in process
  }
}
