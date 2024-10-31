import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () => ExamSelectionViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Exam Selection',
                style: Theme.of(context).textTheme.headline6),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'What is your targeted exam?',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your exam',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: viewModel.onSearchChanged,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.filteredExams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(viewModel.filteredExams[index]),
                      onTap: () =>
                          viewModel.selectExam(viewModel.filteredExams[index]),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed:
                      viewModel.canProceed ? viewModel.proceedToNext : null,
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
