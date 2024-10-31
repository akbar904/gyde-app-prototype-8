
// lib/features/study_planning/exam_selection_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () => ExamSelectionViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Select Exam'),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: model.exams.length,
                itemBuilder: (context, index) {
                  final exam = model.exams[index];
                  return ListTile(
                    title: Text(exam.name),
                    subtitle: Text(exam.description),
                    onTap: () => model.selectExam(exam),
                  );
                },
              ),
      ),
    );
  }
}
```

```dart
// lib/features/study_planning/exam_selection_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'exam.dart';

class ExamSelectionViewModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();
  
  List<Exam> _exams = [];
  List<Exam> get exams => _exams;

  void initialize() async {
    setBusy(true);
    // Fetch exams from a repository or service
    _exams = await fetchExams();
    setBusy(false);
  }

  Future<void> selectExam(Exam exam) async {
    // Handle logic for exam selection
    // Example: Navigate to the next view
    await _navigationService.navigateTo('StudyPlanViewRoute', arguments: exam);
  }

  Future<List<Exam>> fetchExams() async {
    // Replace with actual data fetching logic
    return [
      Exam(name: 'Exam 1', description: 'Description 1'),
      Exam(name: 'Exam 2', description: 'Description 2'),
    ];
  }
}

class Exam {
  final String name;
  final String description;

  Exam({required this.name, required this.description});
}
