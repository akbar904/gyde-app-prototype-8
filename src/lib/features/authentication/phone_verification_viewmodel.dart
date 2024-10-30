import 'package:stacked/stacked.dart';

class PhoneVerificationViewModel extends BaseViewModel {
  String _phoneNumber = '';
  String _verificationCode = '';
  bool _isCodeSent = false;
  bool _isVerifying = false;

  String get phoneNumber => _phoneNumber;
  String get verificationCode => _verificationCode;
  bool get isCodeSent => _isCodeSent;
  bool get isVerifying => _isVerifying;

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  Future<void> sendVerificationCode() async {
    if (_phoneNumber.isNotEmpty) {
      setBusy(true);
      // Simulate sending a verification code to the phone number.
      await Future.delayed(Duration(seconds: 2));
      _isCodeSent = true;
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> verifyCode() async {
    if (_verificationCode.isNotEmpty && _isCodeSent) {
      _isVerifying = true;
      notifyListeners();
      // Simulate verification process.
      await Future.delayed(Duration(seconds: 2));
      _isVerifying = false;
      notifyListeners();
      // Handle successful verification logic here, e.g., navigate to next screen.
    }
  }

  void resetVerificationProcess() {
    _phoneNumber = '';
    _verificationCode = '';
    _isCodeSent = false;
    _isVerifying = false;
    notifyListeners();
  }
}
