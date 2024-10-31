import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:com.com.walturn.gyde_app/app/app.locator.dart';
import 'package:com.com.walturn.gyde_app/app/app.router.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// Handles the 'Get Started' button press.
  void onGetStarted() {
    // Navigate to HomeView after getting started
    _navigationService.navigateTo(Routes.homeView);
  }
}
