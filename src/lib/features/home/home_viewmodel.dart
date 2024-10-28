import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  String currentLocation = "New York, USA";
  String chauffeurName = "Edward";
  double chauffeurRating = 4.8;
  String chauffeurStatus = "Online";
  String vehicleModel = "BMW 7 Series";
  String hourlyRate = "\$65/hour";
  String availability = "Mon - Sat, 09:00 am - 05:00 pm";

  List<String> serviceCategories = [
    "Airport Trips",
    "Eco Friendly",
    "Shared Rides"
  ];

  int selectedRideTab = 0; // 0: Upcoming, 1: Past, 2: Canceled

  void setSelectedRideTab(int index) {
    selectedRideTab = index;
    rebuildUi();
  }

  Future<void> navigateToBooking() async {
    // TODO: Implement booking navigation
  }

  Future<void> navigateToProfile() async {
    // TODO: Implement profile navigation
  }

  Future<void> showLocationSelector() async {
    // TODO: Implement location selection
  }

  void selectServiceCategory(String category) {
    // TODO: Implement service category selection
  }
}
