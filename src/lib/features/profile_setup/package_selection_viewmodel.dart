import 'package:stacked/stacked.dart';

class PackageSelectionViewModel extends BaseViewModel {
  // List of available packages with their features and prices
  final List<Package> packages = [
    Package(
      name: 'Corporate Elite Package',
      price: 5000,
      features: [
        'Priority Booking',
        'Unlimited Mileage',
        'Dedicated Chauffeur',
        'Luxury Vehicle',
      ],
    ),
    Package(
      name: 'Executive Package',
      price: 1000,
      features: [
        'Priority Booking',
        'Fixed Monthly Mileage',
        'Luxury Vehicle',
      ],
    ),
    Package(
      name: 'VIP Package',
      price: 2500,
      features: [
        'Flexible Booking',
        'Extended Mileage',
        'Luxury Vehicle',
      ],
    ),
  ];

  // Selected package
  Package? selectedPackage;

  // Function to select a package
  void selectPackage(Package package) {
    selectedPackage = package;
    notifyListeners();
  }

  // Function to proceed with the selected package
  void proceedWithSelection() {
    if (selectedPackage != null) {
      // Handle the logic to proceed with the selected package
      // For example, navigate to the payment method screen
    } else {
      // Handle the case when no package is selected
      // For example, show a message to the user to select a package
    }
  }
}

class Package {
  final String name;
  final int price;
  final List<String> features;

  Package({required this.name, required this.price, required this.features});
}
