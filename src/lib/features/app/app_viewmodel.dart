import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for chauffeur-related operations
abstract class IChauffeurRepository {
  Future<Map<String, dynamic>> getFeaturedChauffeur();
  Future<List<Map<String, dynamic>>> getServiceCategories();
}

/// Mock implementation of IChauffeurRepository
class MockChauffeurRepository implements IChauffeurRepository {
  @override
  Future<Map<String, dynamic>> getFeaturedChauffeur() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'name': 'John Smith',
      'rating': 4.9,
      'trips': 234,
      'image': 'assets/images/chauffeur.png'
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getServiceCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      {'name': 'One Way', 'icon': 'assets/icons/one_way.png'},
      {'name': 'Multi Stop', 'icon': 'assets/icons/multi_stop.png'},
      {'name': 'Hourly', 'icon': 'assets/icons/hourly.png'}
    ];
  }
}

class AppViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IChauffeurRepository _chauffeurRepository;

  AppViewModel(
      {required NavigationService navigationService,
      required IChauffeurRepository chauffeurRepository})
      : _navigationService = navigationService,
        _chauffeurRepository = chauffeurRepository;

  // Featured chauffeur data
  Map<String, dynamic>? _featuredChauffeur;
  Map<String, dynamic>? get featuredChauffeur => _featuredChauffeur;

  // Service categories
  List<Map<String, dynamic>> _serviceCategories = [];
  List<Map<String, dynamic>> get serviceCategories => _serviceCategories;

  // Loading states
  bool _isLoadingChauffeur = false;
  bool get isLoadingChauffeur => _isLoadingChauffeur;

  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  /// Initialize the view model and load initial data
  Future<void> initialize() async {
    await Future.wait([loadFeaturedChauffeur(), loadServiceCategories()]);
  }

  /// Load featured chauffeur details
  Future<void> loadFeaturedChauffeur() async {
    try {
      _isLoadingChauffeur = true;
      notifyListeners();

      _featuredChauffeur = await _chauffeurRepository.getFeaturedChauffeur();
    } catch (e) {
      _featuredChauffeur = null;
      // Handle error appropriately
    } finally {
      _isLoadingChauffeur = false;
      notifyListeners();
    }
  }

  /// Load service categories
  Future<void> loadServiceCategories() async {
    try {
      _isLoadingCategories = true;
      notifyListeners();

      _serviceCategories = await _chauffeurRepository.getServiceCategories();
    } catch (e) {
      _serviceCategories = [];
      // Handle error appropriately
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  /// Navigate to booking view based on service type
  void navigateToBooking(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'one way':
        _navigationService.navigateTo('/one-way-booking');
        break;
      case 'multi stop':
        _navigationService.navigateTo('/multi-stop-booking');
        break;
      case 'hourly':
        _navigationService.navigateTo('/hourly-booking');
        break;
      default:
        // Handle invalid service type
        break;
    }
  }

  /// Clean up resources
  @override
  void dispose() {
    // Clean up any resources/subscriptions
    super.dispose();
  }
}
