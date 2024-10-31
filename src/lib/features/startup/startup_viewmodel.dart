import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';

/// ViewModel for the SplashView, handles initialization logic and state management.
class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// Initializes the splash screen and handles navigation to the welcome view.
  Future<void> initialize() async {
    setBusy(true);
    try {
      // Simulate a loading delay, e.g., fetching initial configuration
      await Future.delayed(Duration(seconds: 3));
      _navigateToWelcomeView();
    } catch (e) {
      // Handle any initialization errors
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to the WelcomeView after initialization.
  void _navigateToWelcomeView() {
    _navigationService.replaceWith(Routes.welcomeView);
  }

  @override
  void dispose() {
    // Dispose any resources if needed
    super.dispose();
  }
}
