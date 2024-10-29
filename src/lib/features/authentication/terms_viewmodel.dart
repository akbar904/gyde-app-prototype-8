import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TermsViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  bool _termsAccepted = false;

  TermsViewModel({required NavigationService navigationService})
      : _navigationService = navigationService;

  bool get termsAccepted => _termsAccepted;

  void toggleTermsAcceptance() {
    _termsAccepted = !_termsAccepted;
    notifyListeners();
  }

  void onNext() {
    if (_termsAccepted) {
      _navigationService.navigateToModeSelectionView();
    }
  }
}
