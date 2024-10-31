// lib/features/study_planning/exam_selection_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'exam.dart';
import 'exam_repository.dart';

/// ViewModel for the [ExamSelectionView].
/// Responsible for managing business logic for exam selection.
class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ExamRepository _examRepository;

  List<Exam> _exams = [];
  List<Exam> get exams => _exams;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Constructor for [ExamSelectionViewModel].
  /// Requires [NavigationService] and [ExamRepository] for dependency injection.
  ExamSelectionViewModel({
    required NavigationService navigationService,
    required ExamRepository examRepository,
  })  : _navigationService = navigationService,
        _examRepository = examRepository;

  /// Initializes the ViewModel by fetching exams.
  /// Sets the loading state and handles errors.
  void initialize() async {
    setBusy(true);
    try {
      _exams = await _examRepository.fetchExams();
      _errorMessage = null;
    } catch (e) {
      _exams = [];
      _errorMessage = 'Failed to load exams. Please try again later.';
    } finally {
      setBusy(false);
    }
  }

  /// Selects an exam and navigates to the next view.
  /// [exam] is the selected exam.
  Future<void> selectExam(Exam exam) async {
    try {
      await _navigationService.navigateTo(
        'StudyPlanViewRoute',
        arguments: exam,
      );
    } catch (e) {
      _errorMessage = 'Failed to navigate. Please try again later.';
      notifyListeners();
    }
  }
}

/// Repository interface for fetching exams.
abstract class ExamRepository {
  /// Fetches a list of exams.
  /// Returns a [Future] that resolves to a list of [Exam].
  Future<List<Exam>> fetchExams();
}

/// Mock implementation of [ExamRepository].
/// Simulates data fetching with [Future.delayed].
class MockExamRepository implements ExamRepository {
  @override
  Future<List<Exam>> fetchExams() async {
    return Future.delayed(
      Duration(seconds: 2),
      () => [
        Exam(name: 'Exam 1', description: 'Description 1'),
        Exam(name: 'Exam 2', description: 'Description 2'),
      ],
    );
  }
}
