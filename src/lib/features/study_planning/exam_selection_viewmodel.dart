import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for fetching exam options
abstract class IExamRepository {
  Future<List<String>> fetchExamOptions();
}

/// Mock implementation of IExamRepository
class MockExamRepository implements IExamRepository {
  @override
  Future<List<String>> fetchExamOptions() {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        'USMLE Step 1',
        'USMLE Step 2 CK',
        'USMLE Step 3',
        'COMLEX Level 1',
        'COMLEX Level 2-CE',
        'COMLEX Level 3'
      ];
    });
  }
}

class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IExamRepository _examRepository;

  List<String> _examOptions = [];
  List<String> _filteredExams = [];
  String _selectedExam;
  bool _isLoading = false;
  String _errorMessage;

  ExamSelectionViewModel(this._navigationService, this._examRepository);

  List<String> get examOptions => _examOptions;
  List<String> get filteredExams => _filteredExams;
  String get selectedExam => _selectedExam;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  /// Initialize the ViewModel by fetching exam options
  Future<void> initialize() async {
    setBusy(true);
    try {
      _examOptions = await _examRepository.fetchExamOptions();
      _filteredExams = List.from(_examOptions);
    } catch (e) {
      _errorMessage = 'Failed to load exams. Please try again.';
    } finally {
      setBusy(false);
    }
  }

  /// Handles search input changes and filters the exam list
  void onSearchChanged(String query) {
    if (query.isEmpty) {
      _filteredExams = List.from(_examOptions);
    } else {
      _filteredExams = _examOptions
          .where((exam) => exam.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Selects an exam and updates the state
  void selectExam(String exam) {
    _selectedExam = exam;
    notifyListeners();
  }

  /// Checks if the user can proceed to the next step
  bool get canProceed => _selectedExam != null && _selectedExam.isNotEmpty;

  /// Navigates to the next view after validating the selection
  Future<void> proceedToNext() async {
    if (!canProceed) {
      // Handle the error state here, such as showing a message to the user
      _errorMessage = 'Please select an exam to proceed.';
      notifyListeners();
      return;
    }

    // Navigate to the next screen
    await _navigationService.navigateTo('TopicSelectionView');
  }
}
