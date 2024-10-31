import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:com.com.walturn.gyde_app/app/app.locator.dart';

// Define a repository interface for handling complex logic, like authentication
abstract class IAuthRepository {
  /// Fetches authentication options.
  /// Throws an exception if the operation fails.
  Future<List<String>> fetchAuthOptions();
}

// A mock implementation of the repository for demonstration purposes
class MockAuthRepository implements IAuthRepository {
  @override
  Future<List<String>> fetchAuthOptions() async {
    // Simulate network delay
    return Future.delayed(Duration(seconds: 2), () {
      // Simulate fetching data
      return ['Email', 'Phone', 'Social Media'];
    });
  }
}

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final IAuthRepository _authRepository = locator<IAuthRepository>();

  List<String> _authOptions = [];
  List<String> get authOptions => _authOptions;

  /// Initializes the ViewModel, fetching necessary data.
  /// Handles error situations and sets loading states.
  Future<void> initialize() async {
    setBusy(true);
    try {
      _authOptions = await _authRepository.fetchAuthOptions();
    } catch (e) {
      // Handle error gracefully, potentially logging or displaying an error message
      setError('Failed to load authentication options. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to the authentication options view.
  /// Ensure that the view is navigated only if data is loaded properly.
  void navigateToAuthOptions() {
    if (_authOptions.isNotEmpty) {
      _navigationService.navigateTo('AuthOptionsViewRoute');
    } else {
      // Consider showing an error message to the user
      setError('Cannot navigate without authentication options.');
    }
  }

  /// Make sure to clear any resources if required.
  @override
  void dispose() {
    // Perform any cleanup if necessary
    super.dispose();
  }
}
