import 'package:stacked/stacked.dart';

enum PaymentMethod { CreditCard, ApplePay, BankConnection }

class PaymentMethodViewModel extends BaseViewModel {
  PaymentMethod? _selectedMethod;
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  bool _termsAccepted = false;

  PaymentMethod? get selectedMethod => _selectedMethod;
  String get cardNumber => _cardNumber;
  String get expiryDate => _expiryDate;
  String get cvv => _cvv;
  bool get termsAccepted => _termsAccepted;

  void selectPaymentMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  void setCardDetails(String number, String expiry, String cvv) {
    _cardNumber = number;
    _expiryDate = expiry;
    _cvv = cvv;
    notifyListeners();
  }

  void acceptTerms(bool accepted) {
    _termsAccepted = accepted;
    notifyListeners();
  }

  bool validatePaymentDetails() {
    if (_selectedMethod == PaymentMethod.CreditCard) {
      return _cardNumber.isNotEmpty &&
          _expiryDate.isNotEmpty &&
          _cvv.isNotEmpty &&
          _termsAccepted;
    }
    return _selectedMethod != null && _termsAccepted;
  }

  void processPayment() {
    if (!validatePaymentDetails()) {
      // Handle validation error
      return;
    }
    // Proceed with payment processing based on selected method
    // This could involve calling a payment API or SDK
  }
}
