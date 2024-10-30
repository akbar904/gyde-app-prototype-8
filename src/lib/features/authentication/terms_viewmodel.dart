import 'package:stacked/stacked.dart';

class TermsViewModel extends BaseViewModel {
  bool _acceptedTerms = false;

  bool get acceptedTerms => _acceptedTerms;

  void toggleAcceptedTerms() {
    _acceptedTerms = !_acceptedTerms;
    notifyListeners();
  }

  Future<void> acceptTerms() async {
    if (_acceptedTerms) {
      // Logic to handle terms acceptance, e.g., save to a database or secure storage
    } else {
      // Handle the case where terms are not accepted, perhaps show an alert
    }
  }
}
