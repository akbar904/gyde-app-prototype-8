import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for the AuthenticationRepository to handle authentication logic.
abstract class IAuthenticationRepository {
  /// Initiates Google Sign-In process.
  /// Returns true if authentication is successful, false otherwise.
  Future<bool> authenticateWithGoogle();

  /// Initiates Email-based login process.
  Future<void> loginWithEmail();

  /// Initiates user sign-up process.
  Future<void> signUp();
}

class MockAuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<bool> authenticateWithGoogle() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return true; // Simulate successful authentication
  }

  @override
  Future<void> loginWithEmail() async {
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
  }

  @override
  Future<void> signUp() async {
    await Future.delayed(Duration(seconds: 1)); // Simulating network delay
  }
}

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final IAuthenticationRepository _authRepository;

  WelcomeViewModel({
    required NavigationService navigationService,
    required DialogService dialogService,
    required IAuthenticationRepository authRepository,
  })  : _navigationService = navigationService,
        _dialogService = dialogService,
        _authRepository = authRepository;

  /// Triggers Google authentication process.
  Future<void> continueWithGoogle() async {
    try {
      setBusy(true);
      bool isAuthenticated = await _authRepository.authenticateWithGoogle();
      if (isAuthenticated) {
        await _navigationService.navigateTo('/examSelectionView');
      } else {
        // Handle authentication failure
        await _dialogService.showDialog(
          title: 'Authentication Failed',
          description: 'Could not authenticate with Google.',
          buttonTitle: 'OK',
        );
      }
    } catch (e) {
      // Handle unexpected errors
      await _dialogService.showDialog(
        title: 'Error',
        description: 'An unexpected error occurred. Please try again later.',
        buttonTitle: 'OK',
      );
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to Email Authentication screen.
  Future<void> loginWithEmail() async {
    try {
      await _authRepository.loginWithEmail();
      await _navigationService.navigateTo('/emailAuthView');
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'An unexpected error occurred. Please try again later.',
        buttonTitle: 'OK',
      );
    }
  }

  /// Navigates to Sign Up screen.
  Future<void> signUp() async {
    try {
      await _authRepository.signUp();
      await _navigationService.navigateTo('/userInfoView');
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'An unexpected error occurred. Please try again later.',
        buttonTitle: 'OK',
      );
    }
  }

  /// Shows the Terms and Privacy Policy dialog.
  Future<void> showTermsAndPrivacy() async {
    await _dialogService.showDialog(
      title: 'Terms and Privacy Policy',
      description: 'Here are the terms and privacy policy...',
      buttonTitle: 'OK',
    );
  }
}
