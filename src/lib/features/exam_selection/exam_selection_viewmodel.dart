import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

/// Interface for exam selection data repository
abstract class IExamSelectionRepository {
  Future<List<String>> getExamOptions();
  Future<void> saveSelectedExam(String exam);
}

/// Mock implementation of exam repository
class MockExamSelectionRepository implements IExamSelectionRepository {
  @override
  Future<List<String>> getExamOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      'USMLE Step 1',
      'USMLE Step 2 CK',
      'USMLE Step 3',
      'COMLEX Level 1',
      'COMLEX Level 2-CE',
      'COMLEX Level 3'
    ];
  }

  @override
  Future<void> saveSelectedExam(String exam) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

/// ViewModel for exam selection screen
class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IExamSelectionRepository _examRepository;

  ExamSelectionViewModel({
    required NavigationService navigationService,
    IExamSelectionRepository? examRepository,
  })  : _navigationService = navigationService,
        _examRepository = examRepository ?? MockExamSelectionRepository();

  String? _selectedExam;
  String? get selectedExam => _selectedExam;

  List<String> _examOptions = [];
  List<String> get examOptions => _examOptions;

  bool get canProceed => _selectedExam != null;

  /// Initialize view model and load exam options
  Future<void> init() async {
    setBusy(true);
    try {
      _examOptions = await _examRepository.getExamOptions();
      notifyListeners();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  /// Handle exam selection
  Future<void> selectExam(String exam) async {
    setBusy(true);
    try {
      _selectedExam = exam;
      await _examRepository.saveSelectedExam(exam);
      notifyListeners();

      // Navigate to next screen after successful save
      await _navigationService.navigateToTopicSelectionView();
    } catch (e) {
      setError(e);
      _selectedExam = null;
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Navigate back to previous screen
  void navigateBack() {
    _navigationService.back();
  }

  @override
  void dispose() {
    // Cleanup if needed
    super.dispose();
  }
}
