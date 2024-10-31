import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for chauffeur data
abstract class IChauffeurRepository {
  Future<ChauffeurModel> getFeaturedChauffeur();
}

/// Mock implementation of chauffeur repository
class MockChauffeurRepository implements IChauffeurRepository {
  @override
  Future<ChauffeurModel> getFeaturedChauffeur() async {
    await Future.delayed(const Duration(seconds: 1));
    return ChauffeurModel(name: "James Wilson", rating: "4.9", imageUrl: null);
  }
}

/// Model class for chauffeur data
class ChauffeurModel {
  final String name;
  final String rating;
  final String? imageUrl;

  ChauffeurModel({required this.name, required this.rating, this.imageUrl});
}

/// ViewModel for the home screen
class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IChauffeurRepository _chauffeurRepository;

  // Featured chauffeur data
  String? featuredChauffeurName;
  String? featuredChauffeurRating;
  String? featuredChauffeurImage;
  bool isLoading = false;

  // Error state
  String? errorMessage;

  HomeViewModel(this._navigationService,
      [IChauffeurRepository? chauffeurRepository])
      : _chauffeurRepository = chauffeurRepository ?? MockChauffeurRepository();

  /// Initialize the view model and load initial data
  Future<void> initialize() async {
    await loadChauffeurDetails();
  }

  /// Load featured chauffeur details from repository
  Future<void> loadChauffeurDetails() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final chauffeur = await _chauffeurRepository.getFeaturedChauffeur();

      featuredChauffeurName = chauffeur.name;
      featuredChauffeurRating = chauffeur.rating;
      featuredChauffeurImage = chauffeur.imageUrl;
    } catch (e) {
      errorMessage = 'Failed to load chauffeur details';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Retry loading chauffeur details on error
  Future<void> retryLoading() async {
    await loadChauffeurDetails();
  }

  /// Navigate to one-way booking screen
  void navigateToOneWayBooking() {
    _navigationService.navigateTo('/one-way-booking');
  }

  /// Navigate to multi-stop booking screen
  void navigateToMultiStopBooking() {
    _navigationService.navigateTo('/multi-stop-booking');
  }

  /// Navigate to hourly booking screen
  void navigateToHourlyBooking() {
    _navigationService.navigateTo('/hourly-booking');
  }

  @override
  void dispose() {
    // Clean up any resources
    super.dispose();
  }
}
