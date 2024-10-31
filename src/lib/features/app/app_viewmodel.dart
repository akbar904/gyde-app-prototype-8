import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for the App Repository to handle complex business logic
abstract class AppRepository {
  /// Method to fetch user data
  /// Returns user data on success, throws an error on failure
  Future<String> fetchUserData();
}

/// Mock implementation of the AppRepository
class MockAppRepository implements AppRepository {
  @override
  Future<String> fetchUserData() async {
    // Simulate a network call with a delay
    return Future.delayed(Duration(seconds: 2), () => "Mock User Data");
  }
}

class AppViewModel extends BaseViewModel {
  final AppRepository _repository;
  final NavigationService _navigationService = NavigationService();

  String _userData = "";
  String get userData => _userData;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Constructor for AppViewModel with dependency injection
  AppViewModel({required AppRepository repository}) : _repository = repository;

  /// Initialize the ViewModel
  Future<void> init() async {
    setBusy(true);
    _isLoading = true;
    notifyListeners();

    try {
      _userData = await _repository.fetchUserData();
    } catch (e) {
      _errorMessage = "Failed to fetch user data";
    } finally {
      _isLoading = false;
      setBusy(false);
      notifyListeners();
    }
  }

  /// Method to handle user logout
  /// Navigates to the welcome view
  void logout() {
    _navigationService.navigateTo('/welcome');
  }

  @override
  void dispose() {
    // Any necessary cleanup
    super.dispose();
  }
}
