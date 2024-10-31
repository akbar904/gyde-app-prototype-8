import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/question_repository.dart';

class QuestionViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final QuestionRepository _questionRepository;

  // Reactive properties
  List<String> _questions = [];
  List<String> get questions => _questions;

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  String? _selectedAnswer;
  String? get selectedAnswer => _selectedAnswer;

  // Computed properties
  String get currentQuestionText =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : '';
  bool get hasImage => false; // Placeholder for image logic
  String get imageUrl => ''; // Placeholder for image URL
  int get totalQuestions => _questions.length;
  double get progress =>
      totalQuestions > 0 ? _currentQuestionIndex / totalQuestions : 0.0;

  // Constructor with dependency injection
  QuestionViewModel({
    required NavigationService navigationService,
    required QuestionRepository questionRepository,
  })  : _navigationService = navigationService,
        _questionRepository = questionRepository;

  /// Loads the questions for the current session.
  /// Handles any errors that occur during the loading process.
  Future<void> loadQuestions() async {
    try {
      setBusy(true);
      _questions = await _questionRepository.fetchQuestions();
      _currentQuestionIndex = 0;
      notifyListeners();
    } catch (e) {
      // Log the error and show an error message, if necessary
      print('Error loading questions: $e');
      // Optionally, show a dialog or snackbar with an error message
    } finally {
      setBusy(false);
    }
  }

  /// Selects an answer for the current question.
  /// Updates the selected answer state and notifies listeners.
  void selectAnswer(String answer) {
    _selectedAnswer = answer;
    notifyListeners();
  }

  /// Navigates to the next question.
  /// Ensures the current question index is valid.
  void navigateToNext() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      notifyListeners();
    } else {
      _navigationService.navigateTo('nextViewRoute');
    }
  }

  /// Navigates to the previous question.
  /// Ensures the current question index is valid.
  void navigateToPrevious() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _selectedAnswer = null;
      notifyListeners();
    } else {
      _navigationService.back();
    }
  }

  @override
  void dispose() {
    // Perform any necessary cleanup
    super.dispose();
  }
}

// Repository interface for fetching questions
abstract class QuestionRepository {
  /// Fetches the list of questions.
  /// Returns a list of questions as strings.
  /// Throws an exception if an error occurs.
  Future<List<String>> fetchQuestions();
}

// Mock implementation of the QuestionRepository
class MockQuestionRepository implements QuestionRepository {
  @override
  Future<List<String>> fetchQuestions() async {
    // Simulate a delay and return mock data
    await Future.delayed(Duration(seconds: 2));
    return ['Question 1', 'Question 2', 'Question 3'];
  }
}
