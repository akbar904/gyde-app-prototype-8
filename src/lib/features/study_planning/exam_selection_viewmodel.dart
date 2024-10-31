import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:your_app/services/exam_repository.dart';

/// ViewModel for the ExamSelectionView, manages exam selection logic.
class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ExamRepository _examRepository;

  ExamSelectionViewModel({
    required NavigationService navigationService,
    required ExamRepository examRepository,
  })  : _navigationService = navigationService,
        _examRepository = examRepository;

  // List of available exam options
  List<String> _examOptions = [
    'USMLE Step 1',
    'USMLE Step 2 CK',
    'USMLE Step 3',
    'COMLEX Level 1',
    'COMLEX Level 2-CE',
    'COMLEX Level 3',
  ];

  // Currently selected exam
  String? _selectedExam;

  // Getter for exam options
  List<String> get examOptions => _examOptions;
  // Getter for selected exam
  String? get selectedExam => _selectedExam;

  // Indicates whether data is being loaded
  bool _isLoading = false;

  // Getter for loading state
  bool get isLoading => _isLoading;

  /// Selects an exam and updates the UI.
  /// [exam] the exam to be selected.
  void selectExam(String exam) {
    _selectedExam = exam;
    notifyListeners();
  }

  /// Navigates to the next step if an exam is selected.
  Future<void> navigateToNextStep() async {
    if (_selectedExam == null) {
      // Handle the error scenario where no exam is selected
      // Show an error message or a prompt to select an exam
      _showErrorMessage('Please select an exam before proceeding.');
      return;
    }

    _setLoading(true);

    try {
      // Simulate a delay for loading data
      await Future.delayed(Duration(seconds: 1));

      // Implement navigation to the next screen
      await _navigationService.navigateTo('/topicSelectionView');
    } catch (e) {
      // Handle navigation or other errors
      _showErrorMessage(
          'Failed to navigate to the next step. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  /// Sets the loading state and notifies listeners.
  /// [value] the new loading state.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Shows an error message.
  /// [message] the error message to be shown.
  void _showErrorMessage(String message) {
    // Implement a way to show error messages, for example, using a Snackbar
    // or a dialog. This is a placeholder method.
    print(message);
  }
}
