// lib/features/question_bank/question_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:my_app/features/question_bank/question_repository.dart';

/// ViewModel for managing the state and logic of the QuestionView.
class QuestionViewModel extends BaseViewModel {
  final QuestionRepository _questionRepository;

  // Private properties to hold question data and current index
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  String? _selectedAnswer; // Holds the selected answer

  // Public properties for the view to access
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  String? get selectedAnswer => _selectedAnswer;

  /// Indicates if there is a previous question available.
  bool get hasPreviousQuestion => _currentQuestionIndex > 0;

  /// Indicates if there is a next question available.
  bool get hasNextQuestion => _currentQuestionIndex < _questions.length - 1;

  /// Constructor requires a QuestionRepository.
  QuestionViewModel({required QuestionRepository questionRepository})
      : _questionRepository = questionRepository;

  /// Loads questions from the repository.
  /// Sets the busy state, handles errors, and notifies listeners.
  Future<void> loadQuestions() async {
    setBusy(true);
    try {
      _questions = await _questionRepository.fetchQuestions();
      if (_questions.isEmpty) {
        // Handle empty questions scenario
        throw Exception('No questions available.');
      }
      notifyListeners();
    } catch (e) {
      // Log error and notify user
      print('Error loading questions: $e');
      // Optionally use a Snackbar or dialog to inform the user
    } finally {
      setBusy(false);
    }
  }

  /// Selects an answer for the current question.
  /// Validates the answer before selection.
  void selectAnswer(String answer) {
    if (answer.isEmpty) {
      // Handle invalid selection
      print('Invalid answer selection.');
      return;
    }
    _selectedAnswer = answer;
    notifyListeners();
  }

  /// Navigates to the previous question if available.
  void previousQuestion() {
    if (hasPreviousQuestion) {
      _currentQuestionIndex--;
      _selectedAnswer = null; // Reset selected answer for new question
      notifyListeners();
    }
  }

  /// Navigates to the next question if available.
  void nextQuestion() {
    if (hasNextQuestion) {
      _currentQuestionIndex++;
      _selectedAnswer = null; // Reset selected answer for new question
      notifyListeners();
    }
  }

  /// Resets the quiz state to the initial state.
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswer = null;
    notifyListeners();
  }
}
