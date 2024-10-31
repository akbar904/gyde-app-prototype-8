import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Interface for study time persistence and validation
abstract class IStudyTimeRepository {
  Future<void> saveStudyTime(String timeOption);
  Future<String?> getLastSelectedTime();
  Future<bool> validateTimeOption(String timeOption);
}

/// Mock implementation of study time repository
class MockStudyTimeRepository implements IStudyTimeRepository {
  @override
  Future<void> saveStudyTime(String timeOption) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<String?> getLastSelectedTime() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }

  @override
  Future<bool> validateTimeOption(String timeOption) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ['less_than_5', '5_to_10', '10_to_20', 'more_than_20']
        .contains(timeOption);
  }
}

/// ViewModel for the study time selection view
class StudyTimeViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IStudyTimeRepository _studyTimeRepository;

  String? _selectedTimeOption;
  String? get selectedTimeOption => _selectedTimeOption;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _error;
  String? get error => _error;

  StudyTimeViewModel({
    required NavigationService navigationService,
    IStudyTimeRepository? studyTimeRepository,
  })  : _navigationService = navigationService,
        _studyTimeRepository =
            studyTimeRepository ?? MockStudyTimeRepository() {
    _initialize();
  }

  Future<void> _initialize() async {
    setBusy(true);
    try {
      final lastTime = await _studyTimeRepository.getLastSelectedTime();
      if (lastTime != null) {
        _selectedTimeOption = lastTime;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Failed to load previous selection';
    } finally {
      setBusy(false);
    }
  }

  /// Allocates study time and persists selection
  Future<void> allocateStudyTime(String timeOption) async {
    if (_isSaving) return;

    _error = null;
    _isSaving = true;
    notifyListeners();

    try {
      final isValid = await _studyTimeRepository.validateTimeOption(timeOption);
      if (!isValid) {
        throw Exception('Invalid time option selected');
      }

      await _studyTimeRepository.saveStudyTime(timeOption);

      _selectedTimeOption = timeOption;
      notifyListeners();

      await _navigationService.navigateToExamDateView();
    } catch (e) {
      _error = 'Failed to save study time: ${e.toString()}';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /// Checks if given time option is currently selected
  bool isTimeOptionSelected(String timeOption) {
    return _selectedTimeOption == timeOption;
  }

  /// Gets display text for selected study time
  String getStudyTimeText() {
    switch (_selectedTimeOption) {
      case 'less_than_5':
        return 'Less than 5 hours per week';
      case '5_to_10':
        return '5-10 hours per week';
      case '10_to_20':
        return '10-20 hours per week';
      case 'more_than_20':
        return 'More than 20 hours per week';
      default:
        return 'Select study time';
    }
  }

  /// Checks if user can proceed to next screen
  bool canProceed() {
    return _selectedTimeOption != null && !_isSaving;
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
