import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';

// Define a repository interface for fetching exams
abstract class ExamRepository {
  Future<List<String>> fetchExams();
}

// Mock implementation of ExamRepository using Future.delayed
class MockExamRepository implements ExamRepository {
  @override
  Future<List<String>> fetchExams() async {
    return Future.delayed(Duration(seconds: 2), () {
      return [
        'USMLE Step 1',
        'USMLE Step 2 CK',
        'USMLE Step 3',
        'COMLEX Level 1',
        'COMLEX Level 2-CE',
        'COMLEX Level 3',
      ];
    });
  }
}

class ExamSelectionViewModel extends BaseViewModel {
  final ExamRepository _examRepository;
  final NavigationService _navigationService = NavigationService();

  List<String> _examOptions = [];
  String? _selectedExam;
  String? _searchQuery;

  bool _isLoading = false;
  bool _hasError = false;

  ExamSelectionViewModel({required ExamRepository examRepository})
      : _examRepository = examRepository;

  List<String> get examOptions => _searchQuery == null || _searchQuery!.isEmpty
      ? _examOptions
      : _examOptions
          .where((exam) =>
              exam.toLowerCase().contains(_searchQuery!.toLowerCase()))
          .toList();

  String? get selectedExam => _selectedExam;
  bool get canProceed => _selectedExam != null;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  /// Initializes the ViewModel, fetching the list of exams.
  void initialize() async {
    setBusy(true);
    _hasError = false;
    notifyListeners();
    try {
      _examOptions = await _examRepository.fetchExams();
    } catch (e) {
      _hasError = true;
      // Log error or handle accordingly
    } finally {
      setBusy(false);
    }
  }

  /// Updates the search query and refreshes the displayed list.
  void onSearchChanged(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Updates the selected exam and notifies listeners.
  void selectExam(String exam) {
    _selectedExam = exam;
    notifyListeners();
  }

  /// Proceeds to the next step in the flow, if possible.
  void proceedToNextStep() {
    if (canProceed) {
      // Example of navigation; replace with actual navigation logic
      _navigationService.navigateTo('/nextStep');
    } else {
      // Handle error scenario, e.g., show a message
      // _dialogService.showDialog(title: 'Error', description: 'Please select an exam.');
    }
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}
