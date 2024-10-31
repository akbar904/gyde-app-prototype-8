import 'package:stacked/stacked.dart';

/// ViewModel for managing the App's main state and logic.
/// This ViewModel ensures proper state management and interaction
/// with the UI, following the MVVM architecture.
class AppViewModel extends BaseViewModel {
  // Define necessary properties
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters for properties
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Dependency injection for repositories (mock implementation for now)
  final AppRepository _appRepository;

  // Constructor with repository injection
  AppViewModel({required AppRepository appRepository})
      : _appRepository = appRepository;

  /// Initializes the ViewModel
  /// This is where you can add initialization logic if needed.
  void initialize() {
    // Add any necessary initialization logic
    setBusy(true);
    // Initialize or fetch necessary data
    fetchData();
  }

  /// Fetches data required for the app.
  /// This method handles loading state, error handling, and data fetching.
  Future<void> fetchData() async {
    try {
      _setLoading(true);
      // Simulate a repository call
      await _appRepository.getData();
    } catch (e) {
      _setErrorMessage('Failed to fetch data: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sets the error message and notifies listeners.
  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Cleans up resources when the ViewModel is disposed.
  /// This is important for managing memory and resources effectively.
  @override
  void dispose() {
    // Perform any necessary cleanup
    super.dispose();
  }
}

/// Repository interface for data operations in the AppViewModel.
/// This interface abstracts the data source and provides a contract
/// for implementation.
abstract class AppRepository {
  /// Fetches data required by the app.
  /// Returns a Future that completes once the data is fetched.
  Future<void> getData();
}

/// Mock implementation of the AppRepository interface.
/// This simulates data retrieval using Future.delayed.
class MockAppRepository implements AppRepository {
  @override
  Future<void> getData() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    // Simulate successful data fetch
  }
}
