import 'package:stacked/stacked.dart';

class MultiStopBookingViewModel extends BaseViewModel {
  List<String> _stops = [];
  Duration _totalDuration = Duration.zero;

  List<String> get stops => _stops;
  Duration get totalDuration => _totalDuration;

  void addStop(String stop) {
    _stops.add(stop);
    _calculateTotalDuration();
    notifyListeners();
  }

  void removeStop(String stop) {
    _stops.remove(stop);
    _calculateTotalDuration();
    notifyListeners();
  }

  void _calculateTotalDuration() {
    // Mock implementation: In a real scenario, this would involve complex logic
    // possibly including API calls to get estimated durations between stops.
    _totalDuration = Duration(minutes: _stops.length * 30);
  }

  void clearAllStops() {
    _stops.clear();
    _totalDuration = Duration.zero;
    notifyListeners();
  }
}
