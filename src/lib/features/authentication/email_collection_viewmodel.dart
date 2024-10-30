import 'package:stacked/stacked.dart';

class EmailCollectionViewModel extends BaseViewModel {
  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<void> submitEmail() async {
    if (_isValidEmail(_email)) {
      // TODO: Implement email submission logic
      // e.g., calling an API to submit the email for tailored services
    } else {
      // Handle invalid email scenario
      // e.g., show an error message to the user
    }
  }

  bool _isValidEmail(String email) {
    // A simple regex for email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
