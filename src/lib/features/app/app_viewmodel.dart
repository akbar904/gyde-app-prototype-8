
import 'package:stacked/stacked.dart';

/// Repository interface for AppViewModel
abstract class IAppRepository {
  /// Fetches user data from the server
  /// Returns a map containing user details
  /// Throws an exception if the fetch fails
  Future<Map<String, dynamic>> fetchUserData();
}

/// Mock implementation of IAppRepository
class MockAppRepository implements IAppRepository {
  @override
  Future<Map<String, dynamic>> fetchUserData() async {
    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));
    // Return mock data
    return {'name': 'John Doe', 'email': 'john.doe@example.com'};
  }
}

class AppViewModel extends BaseViewModel {
  final IAppRepository _appRepository;

  // Reactive property to hold user data
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error message state
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Constructor with dependency injection
  AppViewModel({required IAppRepository appRepository})
      : _appRepository = appRepository;

  /// Initializes the view model
  /// Fetches user data and updates the state
  Future<void> initialize() async {
    _setLoading(true);
    try {
      _userData = await _appRepository.fetchUserData();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load user data';
      _userData = null;
    } finally {
      _setLoading(false);
    }
  }

  /// Updates the loading state and notifies listeners
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
