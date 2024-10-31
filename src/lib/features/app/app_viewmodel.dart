import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/exceptions/network_exception.dart';
import 'package:my_app/repositories/app_repository.dart';

/// AppViewModel serves as the ViewModel for the main application screen,
/// managing the core logic and state of the application.
class AppViewModel extends BaseViewModel {
  final AppRepository _appRepository = locator<AppRepository>();

  bool _isLoading = false;
  String _errorMessage = '';

  /// Indicates if the application is in a loading state.
  bool get isLoading => _isLoading;

  /// Holds any error message that needs to be displayed.
  String get errorMessage => _errorMessage;

  /// Initializes the ViewModel and fetches initial data.
  Future<void> initialize() async {
    setBusy(true);
    try {
      // Perform any initial data fetching or setup tasks here
      await _appRepository.fetchInitialData();
    } on NetworkException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      setBusy(false);
    }
  }

  /// Sets the loading state and notifies listeners.
  void setBusy(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Clears the error message.
  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    // Perform any necessary cleanup tasks
    super.dispose();
  }
}
