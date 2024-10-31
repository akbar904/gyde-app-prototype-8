import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () => ExamSelectionViewModel(
        navigationService:
            StackedServiceLocator.locateService<NavigationService>(),
      ),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Select Your Exam'),
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
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search exam',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    // This method should be implemented in the ViewModel
                    model.updateSearchQuery(query);
                  },
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.filteredExams.length,
                    itemBuilder: (context, index) {
                      final exam = model.filteredExams[index];
                      return ListTile(
                        title: Text(exam),
                        onTap: () => model.selectExam(exam),
                        selected: model.selectedExam == exam,
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: model.selectedExam != null
                      ? model.navigateToNextScreen
                      : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
