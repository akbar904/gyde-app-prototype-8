
// lib/features/study_planning/study_plan_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/study_planning/study_plan_repository.dart';

/// ViewModel for the StudyPlanView.
/// Manages the state and business logic for generating study plans.
class StudyPlanViewModel extends BaseViewModel {
  final StudyPlanRepository _studyPlanRepository = locator<StudyPlanRepository>();

  String _studyPlan = 'No plan generated yet.';
  bool _isLoading = false;
  String _errorMessage = '';

  /// The current study plan.
  String get studyPlan => _studyPlan;

  /// Indicates if a plan is being generated.
  bool get isLoading => _isLoading;

  /// The error message, if any.
  String get errorMessage => _errorMessage;

  /// Generates a new study plan.
  /// Handles loading state and any potential errors.
  Future<void> generateNewPlan() async {
    _setLoading(true);
    try {
      _studyPlan = await _studyPlanRepository.generateStudyPlan();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to generate study plan. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

// lib/features/study_planning/study_plan_repository.dart
import 'dart:async';

/// Interface for Study Plan repository.
/// Defines the contract for generating study plans.
abstract class StudyPlanRepository {
  /// Generates a study plan.
  /// Returns the plan as a string.
  /// Throws an exception if generation fails.
  Future<String> generateStudyPlan();
}

// lib/features/study_planning/mock_study_plan_repository.dart
import 'dart:async';
import 'package:my_app/features/study_planning/study_plan_repository.dart';

/// Mock implementation of [StudyPlanRepository].
/// Simulates a network call with a delay.
class MockStudyPlanRepository implements StudyPlanRepository {
  @override
  Future<String> generateStudyPlan() async {
    await Future.delayed(Duration(seconds: 2));
    // Simulate a successful response
    return 'New personalized study plan generated!';
  }
}

// lib/app/app.locator.dart
import 'package:stacked/stacked_annotations.dart';
import 'package:my_app/features/study_planning/study_plan_repository.dart';
import 'package:my_app/features/study_planning/mock_study_plan_repository.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: StudyPlanRepository, asType: MockStudyPlanRepository),
  ],
  // other configurations...
)
class AppSetup {}
