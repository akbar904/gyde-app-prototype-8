import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'study_plan_repository.dart';

class StudyPlanViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final StudyPlanRepository _studyPlanRepository;

  // Reactive properties to hold study plan data
  List<WeekPlan> _studyPlan = [];
  List<WeekPlan> get studyPlan => _studyPlan;

  StudyPlanViewModel(this._navigationService, this._studyPlanRepository);

  @override
  void dispose() {
    // Any cleanup if necessary
    super.dispose();
  }

  /// Generates a personalized study plan based on user inputs.
  /// It sets the busy state while generating and handles errors gracefully.
  Future<void> generateStudyPlan() async {
    setBusy(true);
    try {
      // Fetch study plan from the repository
      _studyPlan = await _studyPlanRepository.generateStudyPlan();
      notifyListeners();
    } catch (e) {
      // Handle error scenarios and notify the UI
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  /// Starts the first module from the generated study plan.
  /// Navigates to the relevant module view.
  void startFirstModule() {
    try {
      if (_studyPlan.isEmpty) {
        throw Exception(
            'Study plan is empty. Please generate a study plan first.');
      }
      // Navigate to the first module view
      _navigationService.navigateTo('FirstModuleView');
    } catch (e) {
      // Handle error and notify the UI
      setError(e);
    }
  }
}

/// Contract for the StudyPlanRepository to fetch study plans.
abstract class StudyPlanRepository {
  /// Generates a study plan asynchronously.
  /// Returns a list of WeekPlan which contains the breakdown of hours and modules.
  Future<List<WeekPlan>> generateStudyPlan();
}

/// Mock implementation of StudyPlanRepository using Future.delayed.
class MockStudyPlanRepository implements StudyPlanRepository {
  @override
  Future<List<WeekPlan>> generateStudyPlan() async {
    // Simulating network/database delay
    return Future.delayed(Duration(seconds: 2), () {
      return [
        WeekPlan(hours: 10, modules: 5),
        WeekPlan(hours: 8, modules: 4),
        // More week plans...
      ];
    });
  }
}

/// Represents a plan for a week containing study hours and modules.
class WeekPlan {
  final int hours;
  final int modules;

  WeekPlan({required this.hours, required this.modules});
}
