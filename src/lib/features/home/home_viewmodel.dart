import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

/// Interface for exam date persistence and validation
abstract class IExamDateRepository {
  Future<bool> validateAndSaveExamDate(DateTime date);
  Future<DateTime?> getLastSavedDate();
}

/// Mock implementation of exam date repository
class MockExamDateRepository implements IExamDateRepository {
  @override
  Future<bool> validateAndSaveExamDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<DateTime?> getLastSavedDate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
}

/// ViewModel for exam date selection screen
class ExamDateViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final IExamDateRepository _examDateRepository;

  DateTime? _selectedDate;
  bool _isSaving = false;
  String? _errorMessage;

  ExamDateViewModel({IExamDateRepository? examDateRepository})
      : _examDateRepository = examDateRepository ?? MockExamDateRepository() {
    _init();
  }

  // Getters
  DateTime? get selectedDate => _selectedDate;
  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;
  bool get canContinue => _selectedDate != null && !_isSaving;

  /// Initialize view model and load any saved date
  Future<void> _init() async {
    setBusy(true);
    try {
      final savedDate = await _examDateRepository.getLastSavedDate();
      if (savedDate != null) {
        _selectedDate = savedDate;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load saved date';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Handle exam date selection
  Future<void> selectExamDate(DateTime date) async {
    if (date.isBefore(DateTime.now())) {
      _errorMessage = 'Please select a future date';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _selectedDate = date;
    notifyListeners();
  }

  /// Navigate back to previous screen
  void navigateBack() {
    _navigationService.back();
  }

  /// Continue to study plan after validating and saving date
  Future<void> continueToStudyPlan() async {
    if (_selectedDate == null) return;

    try {
      _isSaving = true;
      notifyListeners();

      final success =
          await _examDateRepository.validateAndSaveExamDate(_selectedDate!);

      if (success) {
        await _navigationService.navigateTo(Routes.studyPlanView);
      } else {
        _errorMessage = 'Failed to save exam date';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'An error occurred while saving';
      _snackbarService.showSnackbar(message: 'Failed to save exam date');
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
