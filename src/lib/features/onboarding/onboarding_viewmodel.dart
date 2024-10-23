import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String? _phoneNumber;
  String? _verificationCode;
  String? _emailAddress;
  bool _termsAccepted = false;

  String? get phoneNumber => _phoneNumber;
  String? get emailAddress => _emailAddress;
  bool get termsAccepted => _termsAccepted;

  Future<void> navigateToAuthOptions() async {
    await _navigationService.navigateToAuthOptionsView();
  }

  Future<void> navigateToPhoneInput() async {
    await _navigationService.navigateToPhoneInputView();
  }

  Future<void> navigateToEmailCollection() async {
    await _navigationService.navigateToEmailCollectionView();
  }

  Future<void> submitPhoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    notifyListeners();
    await _navigationService.navigateToVerificationCodeView();
  }

  Future<void> submitVerificationCode(String code) async {
    _verificationCode = code;
    notifyListeners();
    await _navigationService.navigateToEmailCollectionView();
  }

  Future<void> submitEmail(String email) async {
    _emailAddress = email;
    notifyListeners();
    await _navigationService.navigateToWelcomeConfirmationView();
  }

  Future<void> navigateToTermsConditions() async {
    await _navigationService.navigateToTermsConditionsView();
  }

  void setTermsAccepted(bool accepted) {
    _termsAccepted = accepted;
    notifyListeners();
  }

  void resetOnboarding() {
    _phoneNumber = null;
    _verificationCode = null;
    _emailAddress = null;
    _termsAccepted = false;
    notifyListeners();
  }
}
