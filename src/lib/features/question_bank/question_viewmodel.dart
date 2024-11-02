// lib/features/question_bank/question_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'question_repository.dart'; // Assuming this is the repository to fetch questions

/// ViewModel for the QuestionView, manages question logic.
class QuestionViewModel extends BaseViewModel {
  final QuestionRepository _questionRepository;

  // List of questions to be displayed
  List<Question> _questions = [];
  List<Question> get questions => _questions;

  // Current question index being displayed
  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  // Selected answer for the current question
  String? _selectedAnswer;
  String? get selectedAnswer => _selectedAnswer;

  // Loading state for error handling
  bool _hasError = false;
  bool get hasError => _hasError;

  // Constructor with dependency injection
  QuestionViewModel(this._questionRepository);

  /// Loads questions for the current session.
  /// Handles loading state, error state, and updates the questions list.
  Future<void> loadQuestions() async {
    setBusy(true);
    _hasError = false; // Reset error state
    try {
      _questions = await _questionRepository.fetchQuestions();
    } catch (e) {
      _hasError = true; // Set error state
      // Optionally log the error or show a message
    } finally {
      setBusy(false);
    }
  }

  /// Selects an answer for the current question.
  /// Validates the answer before selection.
  void selectAnswer(String? answer) {
    if (answer == null ||
        !_questions[_currentQuestionIndex].answerOptions.contains(answer)) {
      // Optionally handle invalid selection, e.g. show a message
      return;
    }
    _selectedAnswer = answer;
    notifyListeners();
  }

  /// Advances to the next question if possible.
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  /// Goes back to the previous question if possible.
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  /// Submits the selected answer.
  /// Optionally handles the submission logic and error states.
  void submitAnswer() {
    if (_selectedAnswer == null) {
      // Optionally handle submission error due to no answer selected
      return;
    }
    // Logic to submit the selected answer, possibly invoking a service
  }
}
