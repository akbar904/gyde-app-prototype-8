import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for study plan generation
abstract class IStudyPlanRepository {
  Future<void> generatePlan(
      {required String examType,
      required List<String> topics,
      required int weeklyHours,
      required DateTime examDate});
}

/// Mock implementation of study plan repository
class MockStudyPlanRepository implements IStudyPlanRepository {
  @override
  Future<void> generatePlan(
      {required String examType,
      required List<String> topics,
      required int weeklyHours,
      required DateTime examDate}) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

/// ViewModel for the study plan creation screen
class StudyPlanViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IStudyPlanRepository _studyPlanRepository;

  StudyPlanViewModel(this._navigationService,
      [IStudyPlanRepository? studyPlanRepository])
      : _studyPlanRepository = studyPlanRepository ?? MockStudyPlanRepository();

  String _examType = '';
  List<String> _selectedTopics = [];
  String _studyTime = '';
  DateTime? _examDate;
  String? _errorMessage;

  // Getters for view properties
  String get examType => _examType;
  List<String> get selectedTopics => _selectedTopics;
  String get studyTime => _studyTime;
  DateTime? get examDate => _examDate;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Validates and sets the exam type
  void setExamType(String examType) {
    if (examType.isEmpty) {
      _errorMessage = 'Please select an exam type';
      notifyListeners();
      return;
    }
    _examType = examType;
    _errorMessage = null;
    notifyListeners();
  }

  /// Updates the selected study topics
  void setSelectedTopics(List<String> topics) {
    if (topics.isEmpty) {
      _errorMessage = 'Please select at least one topic';
      notifyListeners();
      return;
    }
    _selectedTopics = topics;
    _errorMessage = null;
    notifyListeners();
  }

  /// Validates and sets weekly study time
  void setStudyTime(String time) {
    if (time.isEmpty) {
      _errorMessage = 'Please select weekly study hours';
      notifyListeners();
      return;
    }
    _studyTime = time;
    _errorMessage = null;
    notifyListeners();
  }

  /// Validates and sets the exam date
  void setExamDate(DateTime date) {
    if (date.isBefore(DateTime.now())) {
      _errorMessage = 'Exam date cannot be in the past';
      notifyListeners();
      return;
    }
    _examDate = date;
    _errorMessage = null;
    notifyListeners();
  }

  /// Checks if all required fields are valid
  bool get canGeneratePlan {
    return _examType.isNotEmpty &&
        _selectedTopics.isNotEmpty &&
        _studyTime.isNotEmpty &&
        _examDate != null &&
        _errorMessage == null;
  }

  /// Generates the study plan based on user selections
  Future<void> generateStudyPlan() async {
    if (!canGeneratePlan) {
      _errorMessage = 'Please fill in all required fields';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _studyPlanRepository.generatePlan(
          examType: _examType,
          topics: _selectedTopics,
          weeklyHours: int.parse(_studyTime),
          examDate: _examDate!);

      // Navigate to plan details view
      await _navigationService.navigateTo('/study-plan-details');
    } catch (e) {
      _errorMessage = 'Failed to generate study plan: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Resets the form state
  void reset() {
    _examType = '';
    _selectedTopics = [];
    _studyTime = '';
    _examDate = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _selectedTopics.clear();
    super.dispose();
  }
}
