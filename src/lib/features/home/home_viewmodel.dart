import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/study_plan/study_plan_repository.dart';

/// ViewModel for the StudyPlanView, managing the generation and display of the study plan.
class StudyPlanViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StudyPlanRepository _studyPlanRepository =
      locator<StudyPlanRepository>();

  // Reactive property to hold the generated study plan
  String _studyPlan;
  String get studyPlan => _studyPlan;

  // Loading state for study plan generation
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error message to display in case of any failures
  String _errorMessage;
  String get errorMessage => _errorMessage;

  StudyPlanViewModel() {
    // Initialize or fetch any necessary data here
    _generateStudyPlan();
  }

  /// Generates a study plan based on user inputs.
  /// Handles loading state and error state.
  Future<void> _generateStudyPlan() async {
    setBusy(true);
    _errorMessage = null;

    try {
      _studyPlan = await _studyPlanRepository.generateStudyPlan();
      setBusy(false);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error generating study plan: ${e.toString()}';
      setBusy(false);
      notifyListeners();
    }
  }

  /// Navigates to another view, e.g., for reviewing or editing the study plan.
  Future<void> navigateToEditPlan() async {
    await _navigationService.navigateTo(Routes.editPlanView);
  }

  @override
  void dispose() {
    // Clean up any resources here if needed
    super.dispose();
  }
}

/// Repository interface for study plan generation logic.
abstract class StudyPlanRepository {
  /// Generates a study plan. This should handle any necessary business logic.
  /// Returns a [Future] containing the generated study plan as a [String].
  Future<String> generateStudyPlan();
}

/// Mock implementation of StudyPlanRepository for demonstration.
class MockStudyPlanRepository implements StudyPlanRepository {
  @override
  Future<String> generateStudyPlan() async {
    // Simulate a network or processing delay
    await Future.delayed(Duration(seconds: 2));
    return 'Generated Study Plan';
  }
}

// Dependency injection setup
void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<StudyPlanRepository>(
      () => MockStudyPlanRepository());
}
