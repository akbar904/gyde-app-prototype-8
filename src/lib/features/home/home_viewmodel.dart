import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  // Profile info
  String currentLocation = 'New York, USA';
  String profileImageUrl = ''; // To be implemented

  // Chauffeur info
  String chauffeurName = 'Edward';
  double chauffeurRating = 4.8;
  String chauffeurStatus = 'Online';
  String vehicleModel = 'BMW 7 Series';
  String hourlyRate = r'$65/hour';
  String availability = 'Mon - Sat, 09:00 am - 05:00 pm';

  // Ride management
  int selectedRideTab = 0; // 0: Upcoming, 1: Past, 2: Canceled
  List<dynamic> rides = []; // To be populated with ride data

  void switchRideTab(int index) {
    selectedRideTab = index;
    rebuildUi();
  }

  void showLocationDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Location',
      description: 'Change your current location',
    );
  }

  void showProfileSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Profile',
      description: 'View and edit your profile',
    );
  }
}
