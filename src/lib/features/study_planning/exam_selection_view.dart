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
          title: Text('Exam Selection'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is your targeted exam?',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: model.examOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(model.examOptions[index]),
                      onTap: () => model.selectExam(model.examOptions[index]),
                      selected: model.selectedExam == model.examOptions[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: model.selectedExam != null
                    ? model.navigateToNextStep
                    : null,
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
