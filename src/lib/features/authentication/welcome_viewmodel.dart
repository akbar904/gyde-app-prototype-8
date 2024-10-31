import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for the repository handling authentication logic.
abstract class IAuthRepository {
  /// Simulates Google sign-in.
  Future<void> signInWithGoogle();

  /// Simulates fetching terms and privacy policy details.
  Future<String> fetchTermsAndPrivacyPolicy();
}

/// Mock implementation of the IAuthRepository using Future.delayed.
class MockAuthRepository implements IAuthRepository {
  @override
  Future<void> signInWithGoogle() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<String> fetchTermsAndPrivacyPolicy() async {
    await Future.delayed(Duration(milliseconds: 500));
    return 'Here are the terms and privacy policy details...';
  }
}

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final IAuthRepository _authRepository;

  WelcomeViewModel({
    required NavigationService navigationService,
    required DialogService dialogService,
    required IAuthRepository authRepository,
  })  : _navigationService = navigationService,
        _dialogService = dialogService,
        _authRepository = authRepository;

  /// Navigates to the email authentication screen.
  Future<void> navigateToEmailAuth() async {
    await _navigationService.navigateTo('/emailAuth');
  }

  /// Initiates Google sign-in process and handles the navigation on success.
  Future<void> continueWithGoogle() async {
    setBusy(true);
    try {
      await _authRepository.signInWithGoogle();
      await _navigationService.navigateTo('/userInfo');
    } catch (e) {
      _dialogService.showDialog(
        title: 'Google Sign-In Failed',
        description:
            'An error occurred during sign-in. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to the sign-up screen.
  Future<void> signUp() async {
    await _navigationService.navigateTo('/signUp');
  }

  /// Shows the terms and privacy policy details in a dialog.
  Future<void> showTermsAndPrivacyPolicy() async {
    try {
      final details = await _authRepository.fetchTermsAndPrivacyPolicy();
      _dialogService.showDialog(
        title: 'Terms and Privacy Policy',
        description: details,
      );
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description:
            'Failed to load terms and privacy policy. Please try again.',
      );
    }
  }
}
