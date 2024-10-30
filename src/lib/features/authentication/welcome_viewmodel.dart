import 'package:stacked/stacked.dart';
import 'package:com.com.walturn.gyde_app/app/app.locator.dart';
import 'package:com.com.walturn.gyde_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// Navigates to the phone verification view
  Future<void> navigateToPhoneVerification() async {
    await _navigationService.navigateTo(Routes.phoneVerificationView);
  }

  /// Navigates to the email collection view
  Future<void> navigateToEmailCollection() async {
    await _navigationService.navigateTo(Routes.emailCollectionView);
  }
}
