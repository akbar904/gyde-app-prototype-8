import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'exam_selection_viewmodel.dart';

class ExamSelectionView extends StatelessWidget {
  const ExamSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExamSelectionViewModel>.reactive(
      viewModelBuilder: () =>
          ExamSelectionViewModel(navigationService: NavigationService()),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('What\'s your targeted exam?'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.navigateBack,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.examOptions.length,
                  itemBuilder: (context, index) {
                    final exam = viewModel.examOptions[index];
                    return ListTile(
                      title: Text(exam),
                      selected: viewModel.selectedExam == exam,
                      leading: Radio<String>(
                        value: exam,
                        groupValue: viewModel.selectedExam,
                        onChanged: (value) => viewModel.selectExam(value!),
                      ),
                      onTap: () => viewModel.selectExam(exam),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
