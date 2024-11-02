import 'package:stacked/stacked.dart';
import 'package:my_app/features/progress_tracking/progress_repository.dart';

/// ViewModel for the ProgressDashboardView, manages progress tracking logic.
class ProgressDashboardViewModel extends BaseViewModel {
  final ProgressRepository _progressRepository;

  ProgressDashboardViewModel(this._progressRepository);

  int _completedQuestions = 0;
  int _totalQuestions = 0;
  bool _hasError = false; // Track if there was an error during load
  String? _errorMessage; // Store error message

  int get completedQuestions => _completedQuestions;
  int get totalQuestions => _totalQuestions;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Loads the user's progress data.
  Future<void> loadProgress() async {
    setBusy(true);
    _hasError = false; // Reset error state before loading
    _errorMessage = null;

    try {
      final progressData = await _progressRepository.fetchProgress();
      _completedQuestions = progressData.completedQuestions;
      _totalQuestions = progressData.totalQuestions;
      notifyListeners();
    } catch (error) {
      _hasError = true;
      _errorMessage = 'Failed to load progress: $error'; // Error message for UI
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Navigate to the next screen.
  void goToNextScreen() {
    // Logic to handle navigation can be added here
    // For example, using a navigation service or pushing a new route
  }
}
