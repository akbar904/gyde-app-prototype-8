
import 'package:stacked/stacked.dart';
import 'package:my_app/features/study_plan/study_plan_repository.dart';

/// ViewModel for managing the Study Plan setup logic.
class StudyPlanViewModel extends BaseViewModel {
	final StudyPlanRepository _studyPlanRepository;

	// Reactive properties
	DateTime? _examDate;
	List<String> _selectedTopics = [];
	bool _isLoading = false;
	String? _errorMessage;

	StudyPlanViewModel(this._studyPlanRepository);

	/// Gets the current exam date.
	DateTime? get examDate => _examDate;

	/// Gets the selected topics for the study plan.
	List<String> get selectedTopics => _selectedTopics;

	/// Indicates if the loading state is active.
	bool get isLoading => _isLoading;

	/// Gets the error message if any occurs during operations.
	String? get errorMessage => _errorMessage;

	/// Sets the exam date for the study plan.
	/// [date] The date to be set for the exam.
	void setExamDate(DateTime date) {
		_examDate = date;
		notifyListeners();
	}

	/// Selects topics for the study plan.
	/// [topics] The list of topics selected by the user.
	void selectTopics(List<String> topics) {
		if (topics.isEmpty) {
			_errorMessage = 'Please select at least one topic.';
			notifyListeners();
			return;
		}
		_selectedTopics = topics;
		_errorMessage = null;
		notifyListeners();
	}

	/// Generates and saves the study schedule based on user input.
	Future<void> generateStudySchedule() async {
		_isLoading = true;
		notifyListeners();

		try {
			if (_examDate == null) {
				_errorMessage = 'Exam date must be set before generating a schedule.';
				return;
			}
			if (_selectedTopics.isEmpty) {
				_errorMessage = 'Please select topics before generating a schedule.';
				return;
			}

			// Simulate saving the study plan to the repository
			await _studyPlanRepository.saveStudyPlan({
				'examDate': _examDate,
				'topics': _selectedTopics,
			});
			_errorMessage = null; // Clear error message on success
		} catch (e) {
			_errorMessage = 'An error occurred while generating the schedule: $e';
		} finally {
			_isLoading = false;
			notifyListeners();
		}
	}

	/// Loads the saved study plan from the repository.
	Future<void> loadSavedStudyPlan() async {
		_isLoading = true;
		notifyListeners();

		try {
			final studyPlan = await _studyPlanRepository.fetchStudyPlan();
			_examDate = studyPlan['examDate'] as DateTime?;
			_selectedTopics = List<String>.from(studyPlan['topics'] ?? []);
			_errorMessage = null;
		} catch (e) {
			_errorMessage = 'Failed to load study plan: $e';
		} finally {
			_isLoading = false;
			notifyListeners();
		}
	}
}

/// Interface for the Study Plan Repository.
abstract class StudyPlanRepository {
	Future<void> saveStudyPlan(Map<String, dynamic> studyPlan);

	Future<Map<String, dynamic>> fetchStudyPlan();
}

/// Mock implementation of StudyPlanRepository for testing.
class MockStudyPlanRepository implements StudyPlanRepository {
	@override
	Future<void> saveStudyPlan(Map<String, dynamic> studyPlan) {
		return Future.delayed(Duration(seconds: 1));
	}

	@override
	Future<Map<String, dynamic>> fetchStudyPlan() {
		return Future.delayed(Duration(seconds: 1), () {
			return {
				'examDate': DateTime.now().add(Duration(days: 30)),
				'topics': ['Anatomy', 'Physiology'],
			};
		});
	}
}
