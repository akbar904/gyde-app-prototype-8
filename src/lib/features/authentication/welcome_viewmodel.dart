import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for authentication repository to abstract the complex logic
abstract class IAuthenticationRepository {
  /// Signs in the user with Google
  /// Returns true if successful, otherwise throws an exception
  Future<bool> signInWithGoogle();
}

/// Mock implementation of IAuthenticationRepository
/// Simulates network calls with Future.delayed
class MockAuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<bool> signInWithGoogle() async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulates a successful authentication
  }
}

/// ViewModel for the WelcomeView
/// Manages authentication and navigation logic
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IAuthenticationRepository _authenticationRepository;

  WelcomeViewModel({
    required NavigationService navigationService,
    required IAuthenticationRepository authenticationRepository,
  })  : _navigationService = navigationService,
        _authenticationRepository = authenticationRepository;

  /// State to track loading status
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Initiates Google sign-in process
  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      final success = await _authenticationRepository.signInWithGoogle();
      if (success) {
        _navigationService.navigateTo('/examSelectionView');
      }
    } catch (e) {
      setError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// Navigates to the email authentication screen
  void navigateToEmailAuth() {
    _navigationService.navigateTo('/emailAuthView');
  }

  /// Sets the loading state and notifies listeners
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
