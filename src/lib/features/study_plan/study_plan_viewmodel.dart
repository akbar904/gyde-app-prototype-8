// lib/features/study_plan/study_plan_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'study_plan_repository.dart';

class StudyPlanViewModel extends BaseViewModel {
  final StudyPlanRepository _repository;
  int _currentStep = 0;
  final List<Step> _steps;
  String? _selectedExam;
  List<String>? _selectedTopics;
  bool _isLoading = false;
  String? _errorMessage;

  StudyPlanViewModel(this._repository) : _steps = _initializeSteps();

  int get currentStep => _currentStep;
  List<Step> get steps => _steps;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Selects an exam and updates the state.
  ///
  /// Throws an error if the exam is invalid.
  void selectExam(String exam) {
    if (exam.isEmpty) {
      _errorMessage = 'Exam cannot be empty';
      notifyListeners();
      return;
    }
    _selectedExam = exam;
    _repository.setSelectedExam(exam);
    notifyListeners();
  }

  /// Selects topics for the study plan.
  ///
  /// Throws an error if no topics are selected.
  void selectTopics(List<String> topics) {
    if (topics.isEmpty) {
      _errorMessage = 'At least one topic must be selected';
      notifyListeners();
      return;
    }
    _selectedTopics = topics;
    _repository.setSelectedTopics(topics);
    notifyListeners();
  }

  /// Generates a study schedule based on selected exam and topics.
  ///
  /// Handles loading state and potential errors during schedule generation.
  Future<void> generateSchedule() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.calculateSchedule();
      _errorMessage = null; // Clear any previous errors
    } catch (e) {
      _errorMessage = 'Failed to generate schedule: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Initializes the steps for the Stepper widget.
  static List<Step> _initializeSteps() {
    return [
      Step(
        title: Text('Select Exam'),
        content: Column(
          children: [
            // Add logic and UI for exam selection
          ],
        ),
      ),
      Step(
        title: Text('Select Topics'),
        content: Column(
          children: [
            // Add logic and UI for topic selection
          ],
        ),
      ),
      Step(
        title: Text('Review and Generate'),
        content: Column(
          children: [
            // Add logic for review before generating schedule
          ],
        ),
      ),
    ];
  }

  /// Updates the current step in the Stepper.
  void onStepTapped(int step) {
    _currentStep = step;
    notifyListeners();
  }

  /// Continues to the next step in the Stepper.
  void onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      _currentStep++;
    }
    notifyListeners();
  }

  /// Cancels the current step in the Stepper.
  void onStepCancel() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    notifyListeners();
  }
}
