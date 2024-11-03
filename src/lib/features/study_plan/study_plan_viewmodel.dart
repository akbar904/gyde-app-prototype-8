import 'package:stacked/stacked.dart';
import 'package:my_app/features/study_plan/study_plan_repository.dart';

class StudyPlanViewModel extends BaseViewModel {
  final StudyPlanRepository _studyPlanRepository;

  StudyPlanViewModel({required StudyPlanRepository studyPlanRepository})
      : _studyPlanRepository = studyPlanRepository;

  DateTime? _examDate;
  String? _selectedExam;
  List<String> _selectedTopics = [];
  String? _studyHours;

  // Reactive properties
  DateTime? get examDate => _examDate;
  String? get selectedExam => _selectedExam;
  List<String> get selectedTopics => _selectedTopics;
  String? get studyHours => _studyHours;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error state
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Sets the exam date for the study plan.
  void setExamDate(DateTime date) {
    _examDate = date;
    notifyListeners();
  }

  /// Sets the selected exam from the dropdown.
  void setExam(String? exam) {
    _selectedExam = exam;
    notifyListeners();
  }

  /// Selects or deselects a topic for the study plan.
  void selectTopic(String topic, bool selected) {
    if (selected) {
      _selectedTopics.add(topic);
    } else {
      _selectedTopics.remove(topic);
    }
    notifyListeners();
  }

  /// Sets the study hours per day.
  void setStudyHours(String hours) {
    if (int.tryParse(hours) != null) {
      _studyHours = hours;
      notifyListeners();
    } else {
      _errorMessage = "Please enter a valid number of hours.";
      notifyListeners();
    }
  }

  /// Generates the study schedule based on selected options.
  Future<void> generateStudySchedule() async {
    if (_examDate == null || _selectedTopics.isEmpty || _studyHours == null) {
      _errorMessage = "Please fill in all fields before generating a schedule.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate a delay for saving the study plan
      await Future.delayed(Duration(seconds: 2));
      // Here you would call your repository method to save the study plan
      await _studyPlanRepository.saveStudyPlan({
        'examDate': _examDate,
        'selectedExam': _selectedExam,
        'selectedTopics': _selectedTopics,
        'studyHours': _studyHours,
      });
      _errorMessage = null; // Clear any previous error
    } catch (e) {
      _errorMessage = "An error occurred while generating the study schedule.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Resets the study plan to initial state.
  void resetStudyPlan() {
    _examDate = null;
    _selectedExam = null;
    _selectedTopics.clear();
    _studyHours = null;
    _errorMessage = null;
    notifyListeners();
  }
}
