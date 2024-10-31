import 'package:stacked/stacked.dart';
import 'package:my_app/services/study_plan_service.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/study_plan.dart';

/// ViewModel for the StudyPlanView, managing the generation and display of the study plan.
class StudyPlanViewModel extends BaseViewModel {
  final StudyPlanService _studyPlanService = locator<StudyPlanService>();

  bool _isLoading = false;
  List<StudyPlan> _studyPlan = [];

  /// Indicates if the study plan is being generated.
  bool get isLoading => _isLoading;

  /// The generated study plan.
  List<StudyPlan> get studyPlan => _studyPlan;

  /// Generates a personalized study plan.
  /// Sets loading states, handles errors, and notifies listeners.
  Future<void> generateStudyPlan() async {
    _setLoading(true);
    try {
      _studyPlan = await _studyPlanService.generatePlan();
    } catch (e) {
      // Log the error and notify user.
      _handleError(e);
    } finally {
      _setLoading(false);
    }
  }

  /// Clears the current study plan.
  void clearStudyPlan() {
    _studyPlan = [];
    notifyListeners();
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Handles errors during study plan generation.
  void _handleError(dynamic error) {
    // Log error or send to monitoring service
    _studyPlan = [];
    // Update UI or show error message
    // Consider using a dialog or a snackbar to notify the user.
  }
}
