import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentMethodViewModel extends BaseViewModel {
  final NavigationService _navigationService;

  PaymentMethodViewModel(this._navigationService);

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;

  String _selectedPaymentMethod = '';
  String get selectedPaymentMethod => _selectedPaymentMethod;

  String _cardNumber = '';
  String get cardNumber => _cardNumber;

  String _expiryDate = '';
  String get expiryDate => _expiryDate;

  String _cvv = '';
  String get cvv => _cvv;

  String _cardholderName = '';
  String get cardholderName => _cardholderName;

  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void setCardNumber(String number) {
    _cardNumber = number;
    notifyListeners();
  }

  void setExpiryDate(String date) {
    _expiryDate = date;
    notifyListeners();
  }

  void setCVV(String cvv) {
    _cvv = cvv;
    notifyListeners();
  }

  void setCardholderName(String name) {
    _cardholderName = name;
    notifyListeners();
  }

  void setTermsAccepted(bool accepted) {
    _termsAccepted = accepted;
    notifyListeners();
  }

  bool validateForm() {
    return _selectedPaymentMethod.isNotEmpty &&
        _termsAccepted &&
        (_selectedPaymentMethod != 'Credit Card' ||
            (_cardNumber.isNotEmpty &&
                _expiryDate.isNotEmpty &&
                _cvv.isNotEmpty &&
                _cardholderName.isNotEmpty));
  }

  Future<void> savePaymentMethod() async {
    if (!validateForm()) return;

    setBusy(true);

    try {
      // Save payment method logic here
      await Future.delayed(Duration(seconds: 1)); // Simulated API call
      _navigationService.navigateToNotificationPermissionView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
