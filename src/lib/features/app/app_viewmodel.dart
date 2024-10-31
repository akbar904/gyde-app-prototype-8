import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for Repository to handle business logic for AppViewModel
abstract class AppRepository {
  /// Fetches necessary data for the view
  /// Throws [DataFetchException] on failure
  Future<void> fetchData();
}

/// Mock implementation of AppRepository
class MockAppRepository implements AppRepository {
  @override
  Future<void> fetchData() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    // Simulate an error for demonstration
    // throw DataFetchException('Failed to fetch data');
  }
}

/// Exception thrown when data fetching fails
class DataFetchException implements Exception {
  final String message;
  DataFetchException(this.message);
}

/// ViewModel for the main application
/// Manages the state and business logic for the application
class AppViewModel extends BaseViewModel {
  final AppRepository _repository;
  final NavigationService _navigationService = NavigationService();

  // Reactive property for loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Constructor with dependency injection
  AppViewModel({required AppRepository repository}) : _repository = repository;

  /// Initializes the ViewModel, fetches initial data
  Future<void> initialize() async {
    setLoading(true);
    try {
      await _repository.fetchData();
      // Handle successful data fetching
    } catch (e) {
      // Handle error, possibly using a dialog to inform the user
      if (e is DataFetchException) {
        // Show error dialog
        _navigationService.showDialog(
          title: 'Error',
          description: e.message,
        );
      }
    } finally {
      setLoading(false);
    }
  }

  /// Sets the loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}
