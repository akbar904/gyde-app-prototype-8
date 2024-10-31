import 'package:stacked/stacked.dart';

/// ViewModel for handling the core logic and state management for the App.
class AppViewModel extends BaseViewModel {
  /// Initializes any necessary data or services for the App.
  Future<void> initialize() async {
    setBusy(true);
    try {
      // Perform any initial setup or data fetching here.
      // This is a placeholder to simulate a delay for initialization.
      await Future.delayed(Duration(seconds: 1));

      // Initialization logic goes here.
    } catch (error) {
      // Handle any initialization errors here.
      // Log the error or show a user-friendly message.
    } finally {
      setBusy(false);
    }
  }

  /// Disposes resources or cancels subscriptions if any.
  /// This is called when the ViewModel is removed from memory.
  @override
  void dispose() {
    // Clean up resources or subscriptions here.
    super.dispose();
  }
}
