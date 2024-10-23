import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileSetupViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  String selectedMode = '';
  String firstName = '';
  String lastName = '';
  String companyName = '';
  String selectedPackage = '';
  String selectedPaymentMethod = '';
  bool notificationsEnabled = false;

  ProfileSetupViewModel(this._navigationService);

  void setMode(String mode) {
    selectedMode = mode;
    notifyListeners();
  }

  void setPersonalInfo(String first, String last) {
    firstName = first;
    lastName = last;
    notifyListeners();
  }

  void setCompanyInfo(String first, String last, String company) {
    firstName = first;
    lastName = last;
    companyName = company;
    notifyListeners();
  }

  void selectPackage(String package) {
    selectedPackage = package;
    notifyListeners();
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void setNotificationPreference(bool enabled) {
    notificationsEnabled = enabled;
    notifyListeners();
  }

  bool get isBusinessMode => selectedMode == 'business';

  void navigateToNext() {
    // Navigation logic based on current state
    notifyListeners();
  }

  void navigateBack() {
    _navigationService.back();
  }

  void completeSetup() {
    // Save profile data and complete setup
    notifyListeners();
  }
}
