import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/topic_repository.dart';

/// ViewModel for topic selection screen that allows users to select study focus areas
class TopicSelectionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _topicRepository = locator<TopicRepository>();

  // Selected topics state
  List<String> _selectedTopics = [];
  List<String> get selectedTopics => _selectedTopics;

  // Available topics state
  List<String> _availableTopics = [];
  List<String> get availableTopics => _availableTopics;

  // Loading states
  bool _isLoadingTopics = false;
  bool get isLoadingTopics => _isLoadingTopics;

  // Error state
  String? _error;
  String? get error => _error;

  // Initialize view model
  Future<void> init() async {
    _isLoadingTopics = true;
    notifyListeners();

    try {
      // Load available topics from repository
      _availableTopics = await _topicRepository.getAvailableTopics();
      _error = null;
    } catch (e) {
      _error = 'Failed to load topics. Please try again.';
      // Fallback to default topics on error
      _availableTopics = [
        'Cardiovascular',
        'Dermatology',
        'Endocrine',
        'Gastrointestinal',
        'Hematology & Oncology',
        'Musculoskeletal',
        'Neurology',
        'Respiratory',
        'Reproductive',
        'Renal & Urinary'
      ];
    } finally {
      _isLoadingTopics = false;
      notifyListeners();
    }
  }

  /// Select multiple topics
  void selectTopics(List<String> topics) {
    if (topics.isEmpty) return;

    _selectedTopics =
        topics.where((t) => _availableTopics.contains(t)).toList();
    notifyListeners();
  }

  /// Navigate back to previous screen
  void navigateBack() {
    _navigationService.back();
  }

  /// Navigate to study time selection if topics are selected
  Future<void> navigateToStudyTime() async {
    if (!canProceed) return;

    try {
      // Save selected topics before navigation
      await _topicRepository.saveSelectedTopics(_selectedTopics);
      await _navigationService.navigateTo(Routes.studyTimeView);
    } catch (e) {
      setError('Failed to save topic selection');
    }
  }

  /// Check if a topic is selected
  bool isTopicSelected(String topic) {
    return _selectedTopics.contains(topic);
  }

  /// Toggle selection state of a topic
  void toggleTopic(String topic) {
    if (_selectedTopics.contains(topic)) {
      _selectedTopics.remove(topic);
    } else {
      _selectedTopics.add(topic);
    }
    notifyListeners();
  }

  /// Check if can proceed to next screen
  bool get canProceed => _selectedTopics.isNotEmpty;

  /// Set error message
  void setError(String message) {
    _error = message;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _selectedTopics.clear();
    super.dispose();
  }
}

/// Repository interface for topic-related operations
abstract class TopicRepository {
  /// Get list of available topics
  Future<List<String>> getAvailableTopics();

  /// Save selected topics
  Future<void> saveSelectedTopics(List<String> topics);
}

/// Mock implementation of TopicRepository
class MockTopicRepository implements TopicRepository {
  @override
  Future<List<String>> getAvailableTopics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      'Cardiovascular',
      'Dermatology',
      'Endocrine',
      'Gastrointestinal',
      'Hematology & Oncology',
      'Musculoskeletal',
      'Neurology',
      'Respiratory',
      'Reproductive',
      'Renal & Urinary'
    ];
  }

  @override
  Future<void> saveSelectedTopics(List<String> topics) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate saving topics
  }
}
