import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> init() async {
    // Add startup logic and initialization here
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to welcome view after splash
    _navigationService.replaceWith(Routes.welcomeView);
  }
}
