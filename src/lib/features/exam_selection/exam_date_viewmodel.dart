import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Repository interface for exam date related operations
abstract class IExamDateRepository {
  /// Saves the selected exam date
  Future<void> saveExamDate(DateTime date);

  /// Gets any existing saved exam date
  Future<DateTime?> getSavedExamDate();
}

/// Implementation of exam date repository
class MockExamDateRepository implements IExamDateRepository {
  @override
  Future<void> saveExamDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<DateTime?> getSavedExamDate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
}

/// ViewModel for exam date selection screen
class ExamDateViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IExamDateRepository _examDateRepository;

  DateTime? _selectedExamDate;
  bool _isSaving = false;
  String? _errorMessage;

  ExamDateViewModel({
    required NavigationService navigationService,
    IExamDateRepository? examDateRepository,
  })  : _navigationService = navigationService,
        _examDateRepository = examDateRepository ?? MockExamDateRepository();

  /// Currently selected exam date
  DateTime? get selectedExamDate => _selectedExamDate;

  /// Whether data is being saved
  bool get isSaving => _isSaving;

  /// Error message to display if any
  String? get errorMessage => _errorMessage;

  /// Initialize the view model
  Future<void> init() async {
    setBusy(true);
    try {
      final savedDate = await _examDateRepository.getSavedExamDate();
      if (savedDate != null && isDateValid(savedDate)) {
        _selectedExamDate = savedDate;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load saved date';
      notifyListeners();
    }
    setBusy(false);
  }

  /// Select an exam date
  Future<void> selectExamDate(DateTime date) async {
    if (!isDateValid(date)) {
      _errorMessage = 'Please select a future date';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _selectedExamDate = date;
    notifyListeners();
  }

  /// Validate if a date is valid (in the future)
  bool isDateValid(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(DateTime(now.year, now.month, now.day));
  }

  /// Check if can proceed to next screen
  bool canProceed() {
    return selectedExamDate != null &&
        isDateValid(selectedExamDate!) &&
        !isSaving;
  }

  /// Navigate to study plan generation
  Future<void> navigateToStudyPlan() async {
    if (!canProceed()) return;

    try {
      _isSaving = true;
      notifyListeners();

      await _examDateRepository.saveExamDate(selectedExamDate!);

      await _navigationService.navigateToStudyPlanView();
    } catch (e) {
      _errorMessage = 'Failed to save exam date';
      notifyListeners();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /// Navigate back
  void navigateBack() {
    _navigationService.back();
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
