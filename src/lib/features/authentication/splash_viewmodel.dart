import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToWelcome() async {
    await Future.delayed(Duration(seconds: 3));
    _navigationService.navigateTo(Routes.welcomeView);
  }
}
