import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'exam_date_viewmodel.dart';

class ExamDateView extends StackedView<ExamDateViewModel> {
  const ExamDateView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ExamDateViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exam Date'),
        leading: BackButton(
          onPressed: viewModel.navigateBack,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'When is your exam date?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                onDateChanged: (date) {
                  if (viewModel.isDateValid(date)) {
                    viewModel.selectExamDate(date);
                  }
                },
              ),
            ),
            if (viewModel.selectedExamDate != null &&
                !viewModel.isDateValid(viewModel.selectedExamDate!))
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Please select a future date',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: viewModel.canProceed()
                    ? viewModel.navigateToStudyPlan
                    : null,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ExamDateViewModel viewModelBuilder(BuildContext context) => ExamDateViewModel(
        navigationService: locator<NavigationService>(),
      );
}
