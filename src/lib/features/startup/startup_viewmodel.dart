
// lib/features/startup/startup_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:my_app/features/authentication/auth_repository.dart';
import 'package:my_app/features/study_plan/study_plan_repository.dart';
import 'package:my_app/features/progress_tracking/progress_repository.dart';

/// ViewModel for the Startup feature, manages startup logic and state.
class StartupViewModel extends BaseViewModel {
	final AuthRepository _authRepository;
	final StudyPlanRepository _studyPlanRepository;
	final ProgressRepository _progressRepository;

	// User input properties
	String _email = '';
	String _password = '';
	DateTime? _examDate;
	List<String> _selectedTopics = [];

	/// Constructor for injecting the repositories.
	StartupViewModel({
		AuthRepository? authRepository,
		StudyPlanRepository? studyPlanRepository,
		ProgressRepository? progressRepository,
	})  : _authRepository = authRepository ?? AuthRepository(),
		  _studyPlanRepository = studyPlanRepository ?? StudyPlanRepository(),
		  _progressRepository = progressRepository ?? ProgressRepository();

	/// Sets the email for the login process.
	void setEmail(String email) {
		_email = email;
		notifyListeners();
	}

	/// Sets the password for the login process.
	void setPassword(String password) {
		_password = password;
		notifyListeners();
	}

	/// Sets the exam date for the study plan.
	void setExamDate(DateTime date) {
		_examDate = date;
		notifyListeners();
	}

	/// Selects topics for the study plan.
	void selectTopics(List<String> topics) {
		_selectedTopics = topics;
		notifyListeners();
	}

	/// Handles user login with email and password.
	Future<void> login() async {
		setBusy(true);
		try {
			if (_email.isEmpty) {
				throw Exception('Email cannot be empty');
			}
			if (_password.length < 6) {
				throw Exception('Password must be at least 6 characters');
			}
			await _authRepository.login(_email, _password);
		} catch (e) {
			// Handle login error, e.g., by showing a dialog
			print('Login failed: $e');
		} finally {
			setBusy(false);
		}
	}

	/// Generates the study schedule based on user input.
	Future<void> generateStudySchedule() async {
		setBusy(true);
		try {
			if (_examDate == null) {
				throw Exception('Exam date must be set.');
			}
			if (_selectedTopics.isEmpty) {
				throw Exception('At least one topic must be selected.');
			}
			// Logic to generate the study schedule
			// For example, creating a StudyPlan object
			// Save the generated study plan using _studyPlanRepository
			// await _studyPlanRepository.saveStudyPlan(generatedStudyPlan);
		} catch (e) {
			// Handle schedule generation error
			print('Schedule generation failed: $e');
		} finally {
			setBusy(false);
		}
	}

	/// Loads the user's progress data.
	Future<void> loadProgress() async {
		setBusy(true);
		try {
			// Logic to load user progress using _progressRepository
			// await _progressRepository.fetchProgress();
		} catch (e) {
			// Handle loading progress error
			print('Progress loading failed: $e');
		} finally {
			setBusy(false);
		}
	}
}
