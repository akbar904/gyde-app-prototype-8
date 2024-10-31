import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for authentication repository
abstract class IAuthenticationRepository {
  /// Authenticates the user with Google.
  /// Returns true if authentication is successful, otherwise throws an error.
  Future<bool> authenticateWithGoogle();

  /// Logs in the user with email.
  /// Returns true if login is successful, otherwise throws an error.
  Future<bool> loginWithEmail(String email, String password);

  /// Signs up a new user.
  /// Returns true if signup is successful, otherwise throws an error.
  Future<bool> signUp(String email, String password);
}

/// Mock implementation of IAuthenticationRepository
class MockAuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<bool> authenticateWithGoogle() async {
    // Simulating network delay
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulate successful authentication
  }

  @override
  Future<bool> loginWithEmail(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulate successful email login
  }

  @override
  Future<bool> signUp(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulate successful signup
  }
}

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IAuthenticationRepository _authRepository;

  WelcomeViewModel({
    required NavigationService navigationService,
    required IAuthenticationRepository authRepository,
  })  : _navigationService = navigationService,
        _authRepository = authRepository;

  bool _isLoading = false;

  /// Indicates if an authentication or any operation is in progress.
  bool get isLoading => _isLoading;

  /// Authenticates the user with Google and navigates on success.
  Future<void> continueWithGoogle() async {
    _setLoading(true);
    try {
      final success = await _authRepository.authenticateWithGoogle();
      if (success) {
        // Navigate to the next screen upon successful authentication
        await _navigationService.navigateTo('/home');
      } else {
        // Handle unsuccessful authentication
        _navigationService.showSnackbar(
          message: 'Google authentication failed.',
        );
      }
    } catch (e) {
      // Handle exceptions and show error message
      _navigationService.showSnackbar(
        message: 'An error occurred during Google authentication.',
      );
    } finally {
      _setLoading(false);
    }
  }

  /// Navigates to the Email Authentication View.
  Future<void> loginWithEmail() async {
    _setLoading(true);
    try {
      await _navigationService.navigateTo('/emailAuth');
    } catch (e) {
      _navigationService.showSnackbar(
        message: 'An error occurred while navigating to login.',
      );
    } finally {
      _setLoading(false);
    }
  }

  /// Navigates to the User Information Collection View.
  Future<void> signUp() async {
    _setLoading(true);
    try {
      await _navigationService.navigateTo('/userInfo');
    } catch (e) {
      _navigationService.showSnackbar(
        message: 'An error occurred while navigating to signup.',
      );
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
