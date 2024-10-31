import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/progress_tracking/repositories/progress_repository.dart';

/// ViewModel for the ProgressView, manages progress tracking logic.
class ProgressViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ProgressRepository _progressRepository;

  ProgressViewModel(this._navigationService, this._progressRepository);

  // Reactive properties for UI bindings
  String _userName = '';
  String get userName => _userName;

  int _daysRemaining = 0;
  int get daysRemaining => _daysRemaining;

  double _overallCompletion = 0.0;
  double get overallCompletion => _overallCompletion;

  int _studyStreak = 0;
  int get studyStreak => _studyStreak;

  // Initialization
  void initialize() async {
    setBusy(true);
    try {
      await loadUserData();
      await trackProgress();
    } catch (e) {
      // Handle initialization errors
    } finally {
      setBusy(false);
    }
  }

  /// Loads user data such as name and days remaining for the exam.
  Future<void> loadUserData() async {
    try {
      _userName = await _progressRepository.getUserName();
      _daysRemaining = await _progressRepository.getDaysRemaining();
      notifyListeners();
    } catch (e) {
      // Handle errors in loading user data
    }
  }

  /// Tracks user progress and updates metrics.
  Future<void> trackProgress() async {
    setBusy(true);
    try {
      _overallCompletion = await _progressRepository.getOverallCompletion();
      _studyStreak = await _progressRepository.getStudyStreak();
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during the tracking process.
    } finally {
      setBusy(false);
    }
  }

  /// Navigates to a different view if needed.
  Future<void> navigateToSomeView() async {
    await _navigationService.navigateTo('/someView');
  }

  @override
  void dispose() {
    // Cleanup resources if necessary
    super.dispose();
  }
}

// Repository interface
abstract class ProgressRepository {
  Future<String> getUserName();
  Future<int> getDaysRemaining();
  Future<double> getOverallCompletion();
  Future<int> getStudyStreak();
}

// Mock implementation of the repository for testing
class MockProgressRepository implements ProgressRepository {
  @override
  Future<String> getUserName() async =>
      Future.delayed(Duration(seconds: 1), () => 'John Doe');

  @override
  Future<int> getDaysRemaining() async =>
      Future.delayed(Duration(seconds: 1), () => 14);

  @override
  Future<double> getOverallCompletion() async =>
      Future.delayed(Duration(seconds: 1), () => 0.75);

  @override
  Future<int> getStudyStreak() async =>
      Future.delayed(Duration(seconds: 1), () => 10);
}
