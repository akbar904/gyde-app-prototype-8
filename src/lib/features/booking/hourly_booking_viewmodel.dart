import 'package:stacked/stacked.dart';

class HourlyBookingViewModel extends BaseViewModel {
  int _duration = 0;
  double _pricePerHour = 65.0;
  double _totalPrice = 0.0;
  String _terms = 'Terms and conditions apply for hourly bookings.';

  int get duration => _duration;
  double get totalPrice => _totalPrice;
  String get terms => _terms;

  void setDuration(int hours) {
    _duration = hours;
    calculateTotalPrice();
    notifyListeners();
  }

  void calculateTotalPrice() {
    _totalPrice = _duration * _pricePerHour;
  }

  void acceptTerms() {
    // Logic to accept terms
    notifyListeners();
  }
}
