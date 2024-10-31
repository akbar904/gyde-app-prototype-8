import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for email authentication
abstract class IEmailAuthRepository {
  Future<bool> sendVerificationCode(String email);
  Future<bool> verifyCode(String email, String code);
}

/// Mock implementation of email auth repository
class MockEmailAuthRepository implements IEmailAuthRepository {
  @override
  Future<bool> sendVerificationCode(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<bool> verifyCode(String email, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

/// View model for email authentication view
class EmailAuthViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IEmailAuthRepository _authRepository;

  EmailAuthViewModel({
    NavigationService? navigationService,
    IEmailAuthRepository? authRepository,
  })  : _navigationService = navigationService ?? NavigationService(),
        _authRepository = authRepository ?? MockEmailAuthRepository();

  String _email = '';
  String _verificationCode = '';
  bool _isValidEmail = false;
  bool _isCodeSent = false;
  String _errorMessage = '';
  bool _hasError = false;

  // Getters
  String get email => _email;
  bool get isValidEmail => _isValidEmail;
  bool get isCodeSent => _isCodeSent;
  String get errorMessage => _errorMessage;
  bool get hasError => _hasError;

  /// Sets and validates email input
  void setEmail(String value) {
    _email = value.trim();
    _isValidEmail = validateEmail(_email);
    _clearError();
    notifyListeners();
  }

  /// Sets verification code input
  void setVerificationCode(String value) {
    _verificationCode = value.trim();
    _clearError();
    notifyListeners();
  }

  /// Validates email format
  bool validateEmail(String email) {
    if (email.isEmpty) return false;

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  /// Sends verification code to email
  Future<void> sendVerificationCode() async {
    if (!_isValidEmail) return;

    try {
      setBusy(true);
      _clearError();

      final success = await _authRepository.sendVerificationCode(_email);

      if (success) {
        _isCodeSent = true;
      } else {
        _setError('Failed to send verification code');
      }
    } catch (e) {
      _setError('An error occurred while sending code');
    } finally {
      setBusy(false);
    }
  }

  /// Verifies entered code
  Future<void> verifyCode() async {
    if (_verificationCode.isEmpty) {
      _setError('Please enter verification code');
      return;
    }

    try {
      setBusy(true);
      _clearError();

      final success =
          await _authRepository.verifyCode(_email, _verificationCode);

      if (success) {
        await _navigationService.navigateTo('/user-info');
      } else {
        _setError('Invalid verification code');
      }
    } catch (e) {
      _setError('An error occurred during verification');
    } finally {
      setBusy(false);
    }
  }

  void _setError(String message) {
    _errorMessage = message;
    _hasError = true;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
    _hasError = false;
  }

  @override
  void dispose() {
    _email = '';
    _verificationCode = '';
    super.dispose();
  }
}
