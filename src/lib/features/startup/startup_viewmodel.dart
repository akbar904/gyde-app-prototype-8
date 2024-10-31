import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

/// Interface for email authentication operations
abstract class IEmailAuthRepository {
  Future<bool> sendVerificationCode(String email);
}

/// Mock implementation of email auth repository
class MockEmailAuthRepository implements IEmailAuthRepository {
  @override
  Future<bool> sendVerificationCode(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

/// ViewModel for handling email authentication flow
class EmailAuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final IEmailAuthRepository _authRepository;

  // Constructor with dependency injection
  EmailAuthViewModel({
    IEmailAuthRepository? authRepository,
  }) : _authRepository = authRepository ?? MockEmailAuthRepository();

  String? _email;
  bool _isEmailValid = false;

  // Getters for reactive state
  String? get email => _email;
  bool get isEmailValid => _isEmailValid;
  bool get canProceed => _isEmailValid && !isBusy;

  /// Validates email format and updates state
  /// Returns true if email is valid
  bool validateEmail(String email) {
    _email = email.trim();
    _isEmailValid =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_email!);
    notifyListeners();
    return _isEmailValid;
  }

  /// Sends verification code to provided email
  /// Shows loading state and handles errors
  Future<void> sendVerificationCode() async {
    if (_email == null || !_isEmailValid) {
      setError('Please enter a valid email');
      return;
    }

    setBusy(true);
    try {
      final success = await _authRepository.sendVerificationCode(_email!);

      if (success) {
        await _navigationService.navigateTo(Routes.userInfoView);
      } else {
        setError('Failed to send verification code');
      }
    } catch (e) {
      setError('An error occurred: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  /// Cleanup any resources or subscriptions
  @override
  void dispose() {
    _email = null;
    super.dispose();
  }
}
