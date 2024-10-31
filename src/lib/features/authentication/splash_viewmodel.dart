import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';

/// Interface for the Splash Repository
abstract class SplashRepository {
  /// Simulate initialization logic
  Future<void> initializeApp();
}

/// Mock implementation of the Splash Repository
class MockSplashRepository implements SplashRepository {
  @override
  Future<void> initializeApp() async {
    // Simulate some delay as if doing real initialization work
    await Future.delayed(Duration(seconds: 3));
  }
}

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SplashRepository _splashRepository = locator<SplashRepository>();

  /// Initialize the splash screen
  Future<void> initialize() async {
    setBusy(true);

    try {
      // Perform any initial setup necessary for the splash screen
      await _splashRepository.initializeApp();
      // Navigate to the Welcome View after initialization
      _navigationService.navigateTo('/welcome');
    } catch (error) {
      // Handle errors during initialization
      setError('Failed to initialize the app. Please try again later.');
    } finally {
      setBusy(false);
    }
  }

  /// Navigate to the welcome view
  Future<void> navigateToWelcome() async {
    try {
      await _navigationService.navigateTo('/welcome');
    } catch (error) {
      setError('Navigation failed. Please try again.');
    }
  }
}
