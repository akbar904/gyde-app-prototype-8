import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  int currentIndex = 0;
  String location = 'New York, USA';
  String chauffeurName = 'Edward';
  double rating = 4.8;
  String chauffeurStatus = 'Online';
  String carDetails = 'BMW 7 Series';
  String availability = 'Mon - Sat, 09:00 am - 05:00 pm';
  String chauffeurDescription =
      'Edward is a top-rated driver with a 4.8-star rating, offering premium service with his BMW 7 Series. Available from Monday to Saturday, 9 AM - 5 PM, at \$65/hour, he ensures a comfortable and reliable ride for every journey.';
  String monthlyFee = '\$5000';

  List<String> rideSegments = ['Upcoming', 'Past', 'Canceled'];
  List<String> serviceCategories = [
    'Airport Trips',
    'Eco Friendly',
    'Shared Rides'
  ];

  // User Profile Data
  String userName = 'John Doe';
  String userPhone = '+65 8123 4567';
  String userEmail = 'j.doe@gmail.com';
  double totalSpent = 6400;
  int totalRides = 94;
  int dailyAverage = 10;
  int monthlyGrowth = 32;

  HomeViewModel(this._navigationService);

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void navigateToProfile() {
    _navigationService.navigateTo('/profile');
  }

  void navigateToChauffeurDetails() {
    _navigationService.navigateTo('/chauffeur-details');
  }

  void sendMessage() {
    // Implement message sending functionality
    notifyListeners();
  }

  String getEmptyStateMessage(int segmentIndex) {
    switch (segmentIndex) {
      case 0:
        return 'You have no upcoming rides';
      case 1:
        return 'You have no past rides';
      case 2:
        return 'No canceled rides';
      default:
        return '';
    }
  }

  String getEmptyStateSubtitle() {
    return 'As soon as you book a ride, all of your relevant details will be shown here.';
  }

  bool isDarkMode = true;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
