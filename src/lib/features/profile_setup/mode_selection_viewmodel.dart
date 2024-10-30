import 'package:stacked/stacked.dart';

class ModeSelectionViewModel extends BaseViewModel {
  String _selectedMode = 'Personal Mode';

  String get selectedMode => _selectedMode;

  void selectMode(String mode) {
    _selectedMode = mode;
    notifyListeners();
  }

  void proceedToProfileInformation() {
    // Logic to navigate to the ProfileInformationView
    // This would typically involve using a navigation service
    // Example: _navigationService.navigateTo(Routes.profileInformationView);
  }
}
