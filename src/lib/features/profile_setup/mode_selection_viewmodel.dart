import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ModeSelectionViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  bool _isBusinessMode = false;
  bool get isBusinessMode => _isBusinessMode;

  void setBusinessMode(bool value) {
    _isBusinessMode = value;
    notifyListeners();
  }

  void selectMode() {
    // Navigate to profile information view with selected mode
    // TODO: Implement navigation
    notifyListeners();
  }
}
