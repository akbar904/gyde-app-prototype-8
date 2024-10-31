import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () => ExamSelectionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Select Your Exam'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'What is your targeted exam?',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search exams',
                  border: OutlineInputBorder(),
                ),
                onChanged: model.onSearchChanged,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.examOptions.length,
                itemBuilder: (context, index) {
                  final exam = model.examOptions[index];
                  return ListTile(
                    title: Text(exam),
                    onTap: () => model.selectExam(exam),
                    selected: model.selectedExam == exam,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: model.canProceed ? model.proceedToNextStep : null,
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
