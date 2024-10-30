import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  // This method could be used to perform any initialization tasks
  // or to navigate to the next screen after the splash screen.
  Future<void> initialize() async {
    // Perform initialization tasks or navigation logic here
    await Future.delayed(Duration(seconds: 3));
    // Navigate to the next screen, e.g., WelcomeView
    // Implement navigation logic here, using Stacked's NavigationService
    // Example: navigationService.navigateTo(Routes.welcomeView);
  }
}
