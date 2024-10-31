import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for managing app data and operations
abstract class IAppRepository {
  Future<bool> initializeApp();
  Future<void> handleLogout();
  Future<void> saveAppState(String key, dynamic value);
  Future<dynamic> getAppState(String key);
}

/// Implementation of app repository with mock data
class MockAppRepository implements IAppRepository {
  @override
  Future<bool> initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<void> handleLogout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> saveAppState(String key, dynamic value) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<dynamic> getAppState(String key) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }
}

/// View model for main app functionality and state management
class AppViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IAppRepository _appRepository;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  AppViewModel({
    NavigationService? navigationService,
    IAppRepository? appRepository,
  })  : _navigationService = navigationService ?? NavigationService(),
        _appRepository = appRepository ?? MockAppRepository();

  /// Initialize the app and required services
  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      _isInitialized = await _appRepository.initializeApp();

      _error = null;
    } catch (e) {
      _error = 'Failed to initialize app: $e';
      _isInitialized = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Handle user logout
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _appRepository.handleLogout();

      // Navigate to welcome screen
      await _navigationService.clearStackAndShow('/welcome-view');

      _error = null;
    } catch (e) {
      _error = 'Logout failed: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Save app state
  Future<void> saveState(String key, dynamic value) async {
    try {
      await _appRepository.saveAppState(key, value);
    } catch (e) {
      _error = 'Failed to save state: $e';
      notifyListeners();
    }
  }

  /// Get app state
  Future<dynamic> getState(String key) async {
    try {
      return await _appRepository.getAppState(key);
    } catch (e) {
      _error = 'Failed to get state: $e';
      notifyListeners();
      return null;
    }
  }

  /// Clear any error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    // Cleanup
    super.dispose();
  }
}
