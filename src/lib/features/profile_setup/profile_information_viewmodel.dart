import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileInformationViewModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();

  String firstName = '';
  String lastName = '';
  String companyName = '';
  bool isBusinessMode = false;

  void updateFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void updateCompanyName(String value) {
    companyName = value;
    notifyListeners();
  }

  void setBusinessMode(bool value) {
    isBusinessMode = value;
    notifyListeners();
  }

  bool isFormValid() {
    if (firstName.isEmpty || lastName.isEmpty) {
      return false;
    }

    if (isBusinessMode && companyName.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> saveAndContinue() async {
    if (!isFormValid()) {
      return;
    }

    setBusy(true);

    try {
      // Save profile information
      // Navigate to next screen
      _navigationService.navigateToPackageSelectionView();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }
}
