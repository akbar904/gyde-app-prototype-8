import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HourlyBookingViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  int _selectedHours = 1;
  double _pricePerHour = 65.0;
  bool _termsAccepted = false;

  int get selectedHours => _selectedHours;
  double get totalPrice => _selectedHours * _pricePerHour;
  bool get termsAccepted => _termsAccepted;

  void incrementHours() {
    if (_selectedHours < 12) {
      _selectedHours++;
      notifyListeners();
    }
  }

  void decrementHours() {
    if (_selectedHours > 1) {
      _selectedHours--;
      notifyListeners();
    }
  }

  void toggleTermsAcceptance() {
    _termsAccepted = !_termsAccepted;
    notifyListeners();
  }

  void updatePricePerHour(double newPrice) {
    _pricePerHour = newPrice;
    notifyListeners();
  }

  Future<void> proceedToBooking() async {
    if (!_termsAccepted) {
      return;
    }

    setBusy(true);

    try {
      // Booking logic implementation
      await Future.delayed(const Duration(seconds: 1));
      // Navigate to confirmation
      _navigationService.back();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void cancelBooking() {
    _navigationService.back();
  }
}
