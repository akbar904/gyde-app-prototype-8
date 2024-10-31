
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/study_plan_repository.dart';
import 'package:my_app/utils/validators.dart';

class StudyPlanViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final StudyPlanRepository _studyPlanRepository;

  // Stepper control properties
  int currentStep = 0;

  // Form properties
  String? selectedExam;
  DateTime? selectedDate;
  List<String> selectedTopics = [];
  TextEditingController hoursController = TextEditingController();
  List<bool> selectedDays = [false, false, false, false, false, false, false];

  // Data source
  List<String> exams = ['Exam 1', 'Exam 2', 'Exam 3']; // Example exam list
  List<String> topics = ['Topic 1', 'Topic 2', 'Topic 3']; // Example topics
  List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  StudyPlanViewModel(this._navigationService, this._studyPlanRepository);

  // Step navigation methods
  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  // Dropdown selection method
  void selectExam(String value) {
    selectedExam = value;
    notifyListeners();
  }

  // Date selection method
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  // Topic selection method
  void toggleTopicSelection(String topic, bool isSelected) {
    if (isSelected) {
      selectedTopics.add(topic);
    } else {
      selectedTopics.remove(topic);
    }
    notifyListeners();
  }

  // Day selection method
  void toggleDaySelection(int index) {
    selectedDays[index] = !selectedDays[index];
    notifyListeners();
  }

  // Plan setup method
  Future<void> setupStudyPlan(Map<String, dynamic> planDetails) async {
    setBusy(true);
    try {
      // Validate inputs
      if (!validatePlanDetails(planDetails)) {
        throw Exception('Invalid plan details');
      }

      // Call repository to save plan details
      await _studyPlanRepository.savePlanDetails(planDetails);

      // Navigate to the next view on success
      _navigationService.navigateTo('/questionView');
    } catch (e) {
      // Handle errors properly
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  // Input validation
  bool validatePlanDetails(Map<String, dynamic> planDetails) {
    return Validators.isNonEmpty(planDetails['selectedExam']) &&
        Validators.isNonEmpty(planDetails['selectedDate'].toString()) &&
        Validators.isNonEmpty(planDetails['selectedTopics']) &&
        Validators.isNumber(planDetails['hoursPerDay']) &&
        planDetails['selectedDays'].contains(true);
  }

  @override
  void dispose() {
    hoursController.dispose();
    super.dispose();
  }
}

// StudyPlanRepository Interface
abstract class StudyPlanRepository {
  /// Saves the study plan details.
  /// Throws an exception if saving fails.
  Future<void> savePlanDetails(Map<String, dynamic> planDetails);
}

// Mock implementation of StudyPlanRepository using Future.delayed
class MockStudyPlanRepository implements StudyPlanRepository {
  @override
  Future<void> savePlanDetails(Map<String, dynamic> planDetails) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network call
    // Add logic to handle success or throw an error
  }
}

// Validators Utility
class Validators {
  static bool isNonEmpty(String value) {
    return value.isNotEmpty;
  }

  static bool isNumber(String value) {
    final number = num.tryParse(value);
    return number != null;
  }
}
