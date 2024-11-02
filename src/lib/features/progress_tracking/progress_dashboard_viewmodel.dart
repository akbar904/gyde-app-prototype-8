
// lib/features/progress_tracking/progress_dashboard_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:my_app/features/progress_tracking/progress_repository.dart';

/// ViewModel for the ProgressDashboardView, managing progress tracking logic.
class ProgressDashboardViewModel extends BaseViewModel {
	final ProgressRepository _progressRepository;

	// Properties to hold user progress data
	String _userName = '';
	String get userName => _userName;

	double _overallCompletion = 0.0;
	double get overallCompletion => _overallCompletion;

	List<Score> _recentScores = [];
	List<Score> get recentScores => _recentScores;

	ProgressDashboardViewModel(this._progressRepository);

	/// Fetches the user's progress data and updates the state.
	Future<void> fetchProgress() async {
		setBusy(true);
		try {
			// Fetch progress data from the repository
			final progressData = await _progressRepository.getProgressData();
			_userName = progressData.userName;
			_overallCompletion = progressData.overallCompletion;
			_recentScores = progressData.recentScores;

			// Notify listeners to update the UI
			notifyListeners();
		} catch (error) {
			// Handle errors appropriately, e.g., log the error or show a message to the user
			print('Error fetching progress: $error');
			// Here you could set an error message property to show in the UI
		} finally {
			setBusy(false);
		}
	}

	/// Releases resources or performs cleanup when the ViewModel is disposed.
	@override
	void dispose() {
		// Perform any necessary cleanup here if needed
		super.dispose();
	}
}
