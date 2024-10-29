import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PackageSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();

  String _selectedPackage = '';
  final List<PackageOption> _packages = [
    PackageOption(name: 'Corporate Elite Package', price: 5000, features: [
      'Dedicated chauffeur',
      '24/7 availability',
      'Premium vehicles',
      'Priority booking',
    ],),
    PackageOption(name: 'Executive Package', price: 1000, features: [
      'Professional chauffeur',
      'Business hours service',
      'Luxury vehicles',
      'Standard booking',
    ],),
    PackageOption(name: 'VIP Package', price: 2500, features: [
      'Personal chauffeur',
      'Extended hours',
      'Premium vehicles',
      'Priority support',
    ],),
  ];

  String get selectedPackage => _selectedPackage;
  List<PackageOption> get packages => _packages;

  void selectPackage(String packageName) {
    _selectedPackage = packageName;
    notifyListeners();
  }

  Future<void> navigateToPaymentMethod() async {
    if (_selectedPackage.isNotEmpty) {
      await _navigationService.navigateToPaymentMethodView();
    }
  }

  bool isPackageSelected(String packageName) {
    return _selectedPackage == packageName;
  }
}

class PackageOption {

  PackageOption(
      {required this.name, required this.price, required this.features,});
  final String name;
  final double price;
  final List<String> features;
}
