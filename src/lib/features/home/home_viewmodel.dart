import 'package:gyde_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gyde_app/repositories/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final HomeRepository _homeRepository = locator<HomeRepository>();

  // Reactive properties for UI binding
  List<String> serviceCategories = [];
  String featuredChauffeur = '';
  List<String> rideList = [];
  bool isLoading = false;

  /// Loads data for the home view, including service categories, featured chauffeur,
  /// and ride list. Manage loading state and error handling.
  Future<void> loadHomeData() async {
    setBusy(true);
    try {
      serviceCategories = await _homeRepository.getServiceCategories();
      featuredChauffeur = await _homeRepository.getFeaturedChauffeur();
      rideList = await _homeRepository.getRideList();
    } catch (e) {
      // Handle errors by showing a dialog
      _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Error',
        description: 'Failed to load home data. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  /// Shows a dialog with the given [title] and [description].
  /// Used for displaying messages to the user.
  void showDialog(String title, String description) {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: title,
      description: description,
    );
  }

  /// Shows a bottom sheet with the given [title] and [description].
  /// Used for displaying additional options or information.
  void showBottomSheet(String title, String description) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: title,
      description: description,
    );
  }
}

// HomeRepository interface defining methods for data fetching
abstract class HomeRepository {
  /// Fetches a list of service categories.
  Future<List<String>> getServiceCategories();

  /// Fetches details of the featured chauffeur.
  Future<String> getFeaturedChauffeur();

  /// Fetches a list of rides.
  Future<List<String>> getRideList();
}

// Mock implementation of HomeRepository for testing
class MockHomeRepository implements HomeRepository {
  @override
  Future<List<String>> getServiceCategories() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => ['Airport Trips', 'Eco Friendly', 'Shared Rides'],
    );
  }

  @override
  Future<String> getFeaturedChauffeur() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'Edward, Rating: 4.8, Online, BMW 7 Series',
    );
  }

  @override
  Future<List<String>> getRideList() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => ['Ride 1', 'Ride 2', 'Ride 3'],
    );
  }
}

// Registering the MockHomeRepository for dependency injection
void setupLocator() {
  locator.registerLazySingleton<HomeRepository>(() => MockHomeRepository());
}
