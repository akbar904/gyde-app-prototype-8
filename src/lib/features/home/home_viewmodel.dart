import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Repository interfaces
abstract class IRideRepository {
  Future<List<Map<String, dynamic>>> getRides(String filter);
  Future<void> bookRide(Map<String, dynamic> rideDetails);
}

abstract class IChauffeurRepository {
  Future<Map<String, dynamic>> getFeaturedChauffeur();
  Future<List<Map<String, dynamic>>> getAllChauffeurs();
}

abstract class ILocationRepository {
  Future<List<String>> getSavedLocations();
  Future<void> updateLocation(String location);
}

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  final IRideRepository _rideRepo;
  final IChauffeurRepository _chauffeurRepo;
  final ILocationRepository _locationRepo;

  HomeViewModel({
    IRideRepository? rideRepo,
    IChauffeurRepository? chauffeurRepo,
    ILocationRepository? locationRepo,
  })  : _rideRepo = rideRepo ?? locator<IRideRepository>(),
        _chauffeurRepo = chauffeurRepo ?? locator<IChauffeurRepository>(),
        _locationRepo = locationRepo ?? locator<ILocationRepository>();

  // Location state
  String _currentLocation = "New York, USA";
  String get currentLocation => _currentLocation;

  // Featured chauffeur state
  Map<String, dynamic> _featuredChauffeur = {};
  Map<String, dynamic> get featuredChauffeur => _featuredChauffeur;

  // Service categories
  final List<String> _serviceCategories = [
    'Airport Trips',
    'Eco Friendly',
    'Shared Rides'
  ];
  List<String> get serviceCategories => _serviceCategories;

  // Ride management state
  String _selectedRideFilter = 'Upcoming';
  String get selectedRideFilter => _selectedRideFilter;
  List<Map<String, dynamic>> _rides = [];
  List<Map<String, dynamic>> get rides => _rides;
  bool _isLoadingRides = false;
  bool get isLoadingRides => _isLoadingRides;

  /// Initializes the view model and loads initial data
  Future<void> initialize() async {
    await _loadFeaturedChauffeur();
    await _loadFilteredRides();
  }

  /// Updates the selected location and refreshes relevant data
  Future<void> updateLocation(String location) async {
    try {
      setBusy(true);
      await _locationRepo.updateLocation(location);
      _currentLocation = location;
      await _loadFeaturedChauffeur();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  /// Shows location selector dialog
  Future<void> showLocationSelector() async {
    final locations = await _locationRepo.getSavedLocations();
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Select Location',
      description: 'Choose your pickup location',
      data: locations,
    );

    if (response?.confirmed == true && response?.data != null) {
      await updateLocation(response!.data);
    }
  }

  /// Handles service category selection
  void onServiceSelected(String service) async {
    await _navigationService.navigateToBookingView(
        service: service, location: _currentLocation);
  }

  /// Updates ride filter and loads filtered rides
  Future<void> setRideFilter(String filter) async {
    _selectedRideFilter = filter;
    await _loadFilteredRides();
  }

  /// Shows chauffeur details bottom sheet
  Future<void> showChauffeurDetails() async {
    await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.notice,
        title: 'Chauffeur Details',
        description: 'View complete chauffeur profile and availability',
        data: _featuredChauffeur);
  }

  /// Navigates to profile view
  void navigateToProfile() {
    _navigationService.navigateToProfileView();
  }

  /// Navigates to booking view
  Future<void> onBookRide() async {
    await _navigationService.navigateToBookingView();
  }

  /// Loads featured chauffeur data
  Future<void> _loadFeaturedChauffeur() async {
    try {
      _featuredChauffeur = await _chauffeurRepo.getFeaturedChauffeur();
      notifyListeners();
    } catch (e) {
      setError(e);
    }
  }

  /// Loads rides based on selected filter
  Future<void> _loadFilteredRides() async {
    try {
      _isLoadingRides = true;
      notifyListeners();

      _rides = await _rideRepo.getRides(_selectedRideFilter);
    } catch (e) {
      setError(e);
    } finally {
      _isLoadingRides = false;
      notifyListeners();
    }
  }

  /// Handles view all chauffeurs action
  Future<void> viewAllChauffeurs() async {
    await _navigationService.navigateToChauffeurListView();
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
