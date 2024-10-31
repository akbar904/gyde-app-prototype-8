import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../services/auth_service.dart';
import '../services/analytics_service.dart';

/// Repository interface for authentication
abstract class IAuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signOut();
}

/// Mock implementation of auth repository
class MockAuthRepository implements IAuthRepository {
  @override
  Future<void> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate success or error
    if (DateTime.now().millisecond % 2 == 0) {
      throw Exception('Google sign in failed');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

/// ViewModel for the Welcome screen that handles authentication flows
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final IAuthRepository _authRepository;

  WelcomeViewModel({
    IAuthRepository? authRepository,
  }) : _authRepository = authRepository ?? MockAuthRepository();

  bool _hasAcceptedTerms = false;
  bool get hasAcceptedTerms => _hasAcceptedTerms;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Updates terms acceptance status
  void setTermsAccepted(bool accepted) {
    _hasAcceptedTerms = accepted;
    notifyListeners();
  }

  /// Handles Google Sign In flow
  Future<void> signInWithGoogle() async {
    if (!_hasAcceptedTerms) {
      setError('Please accept terms and conditions');
      return;
    }

    try {
      setBusy(true);
      _errorMessage = null;

      await _authRepository.signInWithGoogle();

      _analyticsService.logEvent('google_sign_in_success');

      await _navigationService.navigateTo(Routes.examSelectionView);
    } catch (e) {
      _errorMessage = e.toString();
      _analyticsService.logEvent('google_sign_in_error',
          properties: {'error': e.toString()});
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to email authentication flow
  void navigateToEmailAuth() {
    if (!_hasAcceptedTerms) {
      setError('Please accept terms and conditions');
      return;
    }

    _analyticsService.logEvent('email_auth_selected');
    _navigationService.navigateTo(Routes.emailAuthView);
  }

  /// Navigates to sign up flow
  void navigateToSignUp() {
    if (!_hasAcceptedTerms) {
      setError('Please accept terms and conditions');
      return;
    }

    _analyticsService.logEvent('signup_selected');
    _navigationService.navigateTo(Routes.emailAuthView, arguments: true);
  }

  /// Opens terms of service
  void openTermsOfService() {
    _analyticsService.logEvent('terms_opened');
    _navigationService.navigateTo(Routes.termsView);
  }

  /// Opens privacy policy
  void openPrivacyPolicy() {
    _analyticsService.logEvent('privacy_opened');
    _navigationService.navigateTo(Routes.privacyView);
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
