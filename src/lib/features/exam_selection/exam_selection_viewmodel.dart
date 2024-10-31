import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'exam_repository.dart';

class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ExamRepository _examRepository;

  String? _selectedExam;
  String? _searchQuery;
  List<String> _exams = [];
  List<String> _filteredExams = [];
  String? _errorMessage;

  ExamSelectionViewModel({
    required NavigationService navigationService,
    required ExamRepository examRepository,
  })  : _navigationService = navigationService,
        _examRepository = examRepository;

  String? get selectedExam => _selectedExam;
  List<String> get filteredExams => _filteredExams;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  /// Initializes the ViewModel by fetching the list of exams.
  Future<void> initialize() async {
    setBusy(true);
    try {
      _exams = await _examRepository.fetchExams();
      _filteredExams = _exams;
    } catch (e) {
      _errorMessage = 'Failed to load exams. Please try again later.';
    }
    setBusy(false);
    notifyListeners();
  }

  /// Updates the search query and filters the exam list.
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterExams();
    notifyListeners();
  }

  /// Filters exams based on the current search query.
  void _filterExams() {
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      _filteredExams = _exams
          .where((exam) =>
              exam.toLowerCase().contains(_searchQuery!.toLowerCase()))
          .toList();
    } else {
      _filteredExams = _exams;
    }
  }

  /// Selects an exam and updates the selected state.
  void selectExam(String exam) {
    _selectedExam = exam;
    notifyListeners();
  }

  /// Navigates to the next screen in the exam selection flow.
  Future<void> navigateToNextScreen() async {
    if (_selectedExam != null) {
      await _navigationService.navigateTo('/topicSelection');
    } else {
      _errorMessage = 'Please select an exam before proceeding.';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here
    super.dispose();
  }
}

/// Interface for exam-related operations.
abstract class ExamRepository {
  /// Fetches the list of available exams.
  Future<List<String>> fetchExams();
}

/// Mock implementation of ExamRepository using Future.delayed.
class MockExamRepository implements ExamRepository {
  @override
  Future<List<String>> fetchExams() async {
    return Future.delayed(
        Duration(seconds: 2), () => ['Exam A', 'Exam B', 'Exam C']);
  }
}
