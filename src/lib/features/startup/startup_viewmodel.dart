// lib/features/authentication/welcome_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:aorteq_app/app/app.locator.dart';
import 'package:aorteq_app/app/app.router.dart';

/// ViewModel for the WelcomeView, manages the state and logic for user
/// authentication options and navigation.
class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  /// Navigates to the Email Authentication View.
  ///
  /// Handles any navigation errors and updates state accordingly.
  Future<void> navigateToEmailAuth() async {
    try {
      setBusy(true);
      await _navigationService.navigateTo(Routes.emailAuthView);
    } catch (e) {
      // Log or handle error as needed
      setError('Failed to navigate to Email Auth: $e');
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to the User Info View for guest users.
  ///
  /// Handles any navigation errors and updates state accordingly.
  Future<void> navigateToUserInfo() async {
    try {
      setBusy(true);
      await _navigationService.navigateTo(Routes.userInfoView);
    } catch (e) {
      // Log or handle error as needed
      setError('Failed to navigate to User Info: $e');
    } finally {
      setBusy(false);
    }
  }

  /// Sets an error message to be displayed in the UI.
  ///
  /// This method updates the error state, allowing the view to react
  /// to error conditions appropriately.
  void setError(String message) {
    // Assuming errorMessage is an observable state property
    setBusy(false); // Ensure busy state is reset
    notifyListeners(); // Trigger UI update
  }

  @override
  void dispose() {
    // Perform any cleanup tasks if necessary
    super.dispose();
  }
}
