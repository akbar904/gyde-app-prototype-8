// lib/features/authentication/welcome_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

/// ViewModel for the WelcomeView, managing state and logic for user authentication options.
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// Navigates to the email authentication view.
  /// Handles any potential errors during navigation.
  Future<void> navigateToEmailAuth() async {
    setBusy(true);
    try {
      await _navigationService.navigateTo(Routes.emailAuthView);
    } catch (e) {
      // Handle navigation error
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
